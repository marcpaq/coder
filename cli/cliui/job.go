package cliui

import (
	"fmt"
	"os"
	"os/signal"
	"time"

	"github.com/briandowns/spinner"
	"github.com/charmbracelet/lipgloss"
	"github.com/spf13/cobra"

	"github.com/coder/coder/codersdk"
	"github.com/coder/coder/database"
)

type JobOptions struct {
	Title  string
	Fetch  func() (codersdk.ProvisionerJob, error)
	Cancel func() error
	Logs   func() (<-chan codersdk.ProvisionerJobLog, error)
}

// Job renders a provisioner job.
func Job(cmd *cobra.Command, opts JobOptions) (codersdk.ProvisionerJob, error) {
	var (
		spin = spinner.New(spinner.CharSets[5], 100*time.Millisecond, spinner.WithColor("fgGreen"))

		started   = false
		completed = false
		job       codersdk.ProvisionerJob
	)
	_, _ = fmt.Fprintln(cmd.OutOrStdout(), fmt.Sprintf("%s%s %s", Styles.FocusedPrompt, opts.Title, Styles.Placeholder.Render("(ctrl+c to cancel)")))

	spin.Writer = cmd.OutOrStdout()
	defer spin.Stop()

	// Refreshes the job state!
	refresh := func() {
		var err error
		job, err = opts.Fetch()
		if err != nil {
			// If a single fetch fails, it could be a one-off.
			return
		}

		if !started && job.StartedAt != nil {
			spin.Stop()
			fmt.Fprintf(cmd.OutOrStdout(), Styles.Prompt.String()+"Started "+Styles.Placeholder.Render("[%dms]")+"\n", job.StartedAt.Sub(job.CreatedAt).Milliseconds())
			spin.Start()
			started = true
		}
		if !completed && job.CompletedAt != nil {
			spin.Stop()
			msg := ""
			switch job.Status {
			case codersdk.ProvisionerJobCanceled:
				msg = "Canceled"
			case codersdk.ProvisionerJobFailed:
				msg = "Completed"
			case codersdk.ProvisionerJobSucceeded:
				msg = "Built"
			}
			started := job.CreatedAt
			if job.StartedAt != nil {
				started = *job.StartedAt
			}
			fmt.Fprintf(cmd.OutOrStderr(), Styles.Prompt.String()+msg+" "+Styles.Placeholder.Render("[%dms]")+"\n", job.CompletedAt.Sub(started).Milliseconds())
			spin.Start()
			completed = true
		}

		switch job.Status {
		case codersdk.ProvisionerJobPending:
			spin.Suffix = " Queued"
		case codersdk.ProvisionerJobRunning:
			spin.Suffix = " Running"
		case codersdk.ProvisionerJobCanceling:
			spin.Suffix = " Canceling"
		}
	}
	refresh()
	spin.Start()

	stopChan := make(chan os.Signal, 1)
	defer signal.Stop(stopChan)
	go func() {
		signal.Notify(stopChan, os.Interrupt)
		select {
		case <-cmd.Context().Done():
			return
		case _, ok := <-stopChan:
			if !ok {
				return
			}
		}
		spin.Stop()
		fmt.Fprintf(cmd.OutOrStdout(), Styles.FocusedPrompt.String()+"Gracefully canceling... wait for exit or data loss may occur!\n")
		spin.Start()
		err := opts.Cancel()
		if err != nil {
			fmt.Fprintf(cmd.OutOrStdout(), "Failed to cancel %s...\n", err)
		}
		refresh()
	}()

	logs, err := opts.Logs()
	if err != nil {
		return job, err
	}

	firstLog := false
	ticker := time.NewTicker(time.Second)
	for {
		select {
		case <-cmd.Context().Done():
			return job, cmd.Context().Err()
		case <-ticker.C:
			refresh()
			if job.CompletedAt != nil {
				return job, nil
			}
		case log, ok := <-logs:
			if !ok {
				refresh()
				continue
			}
			if !firstLog {
				refresh()
				firstLog = true
			}
			spin.Stop()
			var style lipgloss.Style
			switch log.Level {
			case database.LogLevelTrace:
				style = defaultStyles.Error
			case database.LogLevelDebug:
				style = defaultStyles.Error
			case database.LogLevelError:
				style = defaultStyles.Error
			case database.LogLevelWarn:
				style = Styles.Warn
			case database.LogLevelInfo:
				style = defaultStyles.Note
			}
			fmt.Fprintln(cmd.OutOrStdout(), fmt.Sprintf("%s %s %s", Styles.Placeholder.Render("|"), style.Render(string(log.Level)), log.Output))
			spin.Start()
		}
	}
}
