//go:build tools
// +build tools

package tools

import (
	_ "github.com/golang/mock/mockgen"
	_ "github.com/golangci/golangci-lint/cmd/golangci-lint"
	_ "github.com/sqlc-dev/sqlc/cmd/sqlc"
)
