package testutil

import (
	"context"
	"errors"
	"io"
	"strings"
	"testing"

	"github.com/hinshun/vt10x"
)

// ReadUntilString emulates a terminal and reads one byte at a time until we
// either see the string we want, or the context expires.
func ReadUntilString(ctx context.Context, t *testing.T, want string, r io.Reader) error {
	return ReadUntil(ctx, t, r, func(line string) bool {
		if strings.TrimSpace(line) == want {
			t.Logf("want: %v\n got:%v", want, line)
			return true
		}
		return false
	})
}

// ReadUntil emulates a terminal and reads one byte at a time until matcher
// returns true or the context expires.  If the matcher is nil, read until EOF.
func ReadUntil(ctx context.Context, t *testing.T, r io.Reader, matcher func(line string) bool) error {
	// output can contain virtual terminal sequences, so we need to parse these
	// to correctly interpret getting what we want.
	term := vt10x.New(vt10x.WithSize(80, 80))
	readErrs := make(chan error, 1)
	defer func() {
		// Dump the terminal contents since they can be helpful for debugging, but
		// skip empty lines since much of the terminal will usually be blank.
		got := term.String()
		lines := strings.Split(got, "\n")
		for _, line := range lines {
			if strings.TrimSpace(line) != "" {
				t.Logf("got: %v", line)
			}
		}
	}()
	for {
		b := make([]byte, 1)
		go func() {
			_, err := r.Read(b)
			readErrs <- err
		}()
		select {
		case err := <-readErrs:
			if err != nil {
				// Avoid logging EOFs with a nil matcher since that means the caller
				// expects an EOF.
				if !errors.Is(err, io.EOF) || matcher != nil {
					t.Logf("err: %v\ngot: %v", err, term)
				}
				return err
			}
			term.Write(b)
		case <-ctx.Done():
			return ctx.Err()
		}
		got := term.String()
		lines := strings.Split(got, "\n")
		for _, line := range lines {
			if matcher != nil && matcher(line) {
				return nil
			}
		}
	}
}
