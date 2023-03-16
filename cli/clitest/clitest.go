package clitest

import (
	"archive/tar"
	"bytes"
	"context"
	"errors"
	"io"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
	"sync/atomic"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/coder/coder/cli"
	"github.com/coder/coder/cli/clibase"
	"github.com/coder/coder/cli/config"
	"github.com/coder/coder/codersdk"
	"github.com/coder/coder/provisioner/echo"
	"github.com/coder/coder/testutil"
)

// New creates a CLI instance with a configuration pointed to a
// temporary testing directory.
func New(t *testing.T, args ...string) (*clibase.Invocation, config.Root) {
	var root cli.RootCmd

	return NewWithCommand(t, root.Command(root.AGPL()), args...)
}

type logWriter struct {
	prefix string
	t      *testing.T
}

func (l *logWriter) Write(p []byte) (n int, err error) {
	trimmed := strings.TrimSpace(string(p))
	if trimmed == "" {
		return len(p), nil
	}
	l.t.Log(
		l.prefix + ": " + trimmed,
	)
	return len(p), nil
}

func NewWithCommand(
	t *testing.T, cmd *clibase.Cmd, args ...string,
) (*clibase.Invocation, config.Root) {
	configDir := config.Root(t.TempDir())
	i := &clibase.Invocation{
		Command: cmd,
		Args:    append([]string{"--global-config", string(configDir)}, args...),
		Stdin:   io.LimitReader(nil, 0),
		Stdout:  (&logWriter{prefix: "stdout", t: t}),
		Stderr:  (&logWriter{prefix: "stderr", t: t}),
	}
	t.Logf("invoking command: %s %s", cmd.Name(), strings.Join(i.Args, " "))

	ctx := testutil.Context(t, testutil.WaitMedium)
	i = i.WithContext(ctx)

	// These can be overridden by the test.
	return i, configDir
}

// SetupConfig applies the URL and SessionToken of the client to the config.
func SetupConfig(t *testing.T, client *codersdk.Client, root config.Root) {
	err := root.Session().Write(client.SessionToken())
	require.NoError(t, err)
	err = root.URL().Write(client.URL.String())
	require.NoError(t, err)
}

// CreateTemplateVersionSource writes the echo provisioner responses into a
// new temporary testing directory.
func CreateTemplateVersionSource(t *testing.T, responses *echo.Responses) string {
	directory := t.TempDir()
	f, err := ioutil.TempFile(directory, "*.tf")
	require.NoError(t, err)
	_ = f.Close()
	data, err := echo.Tar(responses)
	require.NoError(t, err)
	extractTar(t, data, directory)
	return directory
}

func extractTar(t *testing.T, data []byte, directory string) {
	reader := tar.NewReader(bytes.NewBuffer(data))
	for {
		header, err := reader.Next()
		if errors.Is(err, io.EOF) {
			break
		}
		require.NoError(t, err)
		if header.Name == "." || strings.Contains(header.Name, "..") {
			continue
		}
		// #nosec
		path := filepath.Join(directory, header.Name)
		mode := header.FileInfo().Mode()
		if mode == 0 {
			mode = 0o600
		}
		switch header.Typeflag {
		case tar.TypeDir:
			err = os.MkdirAll(path, mode)
			require.NoError(t, err)
		case tar.TypeReg:
			file, err := os.OpenFile(path, os.O_CREATE|os.O_RDWR, mode)
			require.NoError(t, err)
			// Max file size of 10MB.
			_, err = io.CopyN(file, reader, (1<<20)*10)
			if errors.Is(err, io.EOF) {
				err = nil
			}
			require.NoError(t, err)
			err = file.Close()
			require.NoError(t, err)
		}
	}
}

// Start runs the command in a goroutine and cleans it up when
// the test completed.
func Start(t *testing.T, inv *clibase.Invocation) {
	t.Helper()

	closeCh := make(chan struct{})
	go func() {
		defer close(closeCh)
		err := <-StartWithError(t, inv)
		switch {
		case errors.Is(err, context.Canceled):
			return
		default:
			assert.NoError(t, err)
		}
	}()

	t.Cleanup(func() {
		<-closeCh
	})
}

// Run runs the command and asserts that there is no error.
func Run(t *testing.T, inv *clibase.Invocation) {
	t.Helper()

	err := inv.Run()
	require.NoError(t, err)
}

// StartWithError runs the command in a goroutine but returns the error
// instead of asserting it. This is useful for testing error cases.
func StartWithError(t *testing.T, inv *clibase.Invocation) <-chan error {
	t.Helper()

	var (
		errCh       = make(chan error, 1)
		ctx, cancel = context.WithCancel(inv.Context())
	)

	var cleaningUp atomic.Bool

	go func() {
		defer close(errCh)
		err := inv.WithContext(ctx).Run()
		if cleaningUp.Load() && errors.Is(err, context.DeadlineExceeded) {
			// If we're cleaning up, this error is likely related to the
			// CLI teardown process. E.g., the server could be slow to shut
			// down Postgres.
			t.Logf("command %q timed out during test cleanup", inv.Command.FullName())
		}
		errCh <- err
	}()

	// Don't exit test routine until server is done.
	t.Cleanup(func() {
		cancel()
		cleaningUp.Store(true)
		<-errCh
	})
	return errCh
}
