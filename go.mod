module github.com/coder/coder

go 1.20

// Required until https://github.com/hashicorp/terraform-config-inspect/pull/74 is merged.
replace github.com/hashicorp/terraform-config-inspect => github.com/kylecarbs/terraform-config-inspect v0.0.0-20211215004401-bbc517866b88

// Required until https://github.com/chzyer/readline/pull/198 is merged.
replace github.com/chzyer/readline => github.com/kylecarbs/readline v0.0.0-20220211054233-0d62993714c8

// Required until https://github.com/briandowns/spinner/pull/136 is merged.
replace github.com/briandowns/spinner => github.com/kylecarbs/spinner v1.18.2-0.20220329160715-20702b5af89e

// Required until https://github.com/fergusstrange/embedded-postgres/pull/75 is merged.
replace github.com/fergusstrange/embedded-postgres => github.com/kylecarbs/embedded-postgres v1.17.1-0.20220615202325-461532cecd3a

// opencensus-go leaks a goroutine by default.
replace go.opencensus.io => github.com/kylecarbs/opencensus-go v0.23.1-0.20220307014935-4d0325a68f8b

// See https://github.com/kylecarbs/tview/commit/8464256e10a1e85074c7ef9c80346baa60e9ede6
replace github.com/rivo/tview => github.com/kylecarbs/tview v0.0.0-20220309202238-8464256e10a1

// glog has a single goroutine leak on start that we removed in a fork: https://github.com/coder/glog/pull/1.
replace github.com/golang/glog => github.com/coder/glog v1.0.1-0.20220322161911-7365fe7f2cd1

// kcp-go starts a goroutine in an init function that we can't stop. It was
// fixed in our fork:
// https://github.com/coder/kcp-go/commit/83c0904cec69dcf21ec10c54ea666bda18ada831
replace github.com/fatedier/kcp-go => github.com/coder/kcp-go v2.0.4-0.20220409183554-83c0904cec69+incompatible

// https://github.com/tcnksm/go-httpstat/pull/29
replace github.com/tcnksm/go-httpstat => github.com/coder/go-httpstat v0.0.0-20230801153223-321c88088322

// See https://github.com/dlclark/regexp2/issues/63
replace github.com/dlclark/regexp2 => github.com/dlclark/regexp2 v1.7.0

// There are a few minor changes we make to Tailscale that we're slowly upstreaming. Compare here:
// https://github.com/tailscale/tailscale/compare/main...coder:tailscale:main
replace tailscale.com => github.com/coder/tailscale v1.1.1-0.20230815060514-ebed8c967bd2

// This is replaced to include a fix that causes a deadlock when closing the
// wireguard network.
// The branch used is from https://github.com/coder/wireguard-go/tree/colin/tailscale
// It is based on https://github.com/tailscale/wireguard-go/tree/tailscale, but
// includes the upstream fix https://github.com/WireGuard/wireguard-go/commit/b7cd547315bed421a648d0a0f1ee5a0fc1b1151e
replace github.com/tailscale/wireguard-go => github.com/coder/wireguard-go v0.0.0-20230807234434-d825b45ccbf5

// Use our tempfork of gvisor that includes a fix for TCP connection stalls:
// https://github.com/coder/coder/issues/7388
// The basis for this fork is: gvisor.dev/gvisor v0.0.0-20230504175454-7b0a1988a28f
// This is the same version as used by Tailscale `main`:
// https://github.com/tailscale/tailscale/blob/c19b5bfbc391637b11c2acb3c725909a0046d849/go.mod#L88
//
// Latest gvisor otherwise has refactored packages and is currently incompatible with
// Tailscale, to remove our tempfork this needs to be addressed.
replace gvisor.dev/gvisor => github.com/coder/gvisor v0.0.0-20230714132058-be2e4ac102c3

// Switch to our fork that imports fixes from http://github.com/tailscale/ssh.
// See: https://github.com/coder/coder/issues/3371
//
// Note that http://github.com/tailscale/ssh has been merged into the Tailscale
// repo as tailscale.com/tempfork/gliderlabs/ssh, however, we can't replace the
// subpath and it includes changes to golang.org/x/crypto/ssh as well which
// makes importing it directly a bit messy.
replace github.com/gliderlabs/ssh => github.com/coder/ssh v0.0.0-20230621095435-9a7e23486f1c

// Waiting on https://github.com/imulab/go-scim/pull/95 to merge.
replace github.com/imulab/go-scim/pkg/v2 => github.com/coder/go-scim/pkg/v2 v2.0.0-20230221055123-1d63c1222136

require (
	cdr.dev/slog v1.6.1
	cloud.google.com/go/compute/metadata v0.2.3
	github.com/AlecAivazis/survey/v2 v2.3.5
	github.com/acarl005/stripansi v0.0.0-20180116102854-5a71ef0e047d
	github.com/adrg/xdg v0.4.0
	github.com/ammario/tlru v0.3.0
	github.com/andybalholm/brotli v1.0.5
	github.com/armon/circbuf v0.0.0-20190214190532-5111143e8da2
	github.com/awalterschulze/gographviz v2.0.3+incompatible
	github.com/bep/debounce v1.2.1
	github.com/bgentry/speakeasy v0.1.1-0.20220910012023-760eaf8b6816
	github.com/bramvdbogaerde/go-scp v1.2.1-0.20221219230748-977ee74ac37b
	github.com/briandowns/spinner v1.18.1
	github.com/cakturk/go-netstat v0.0.0-20200220111822-e5b49efee7a5
	github.com/cenkalti/backoff/v4 v4.2.1
	github.com/charmbracelet/charm v0.12.4
	github.com/charmbracelet/glamour v0.6.0
	// In later at least v0.7.1, lipgloss changes its terminal detection
	// which breaks most of our CLI golden files tests.
	github.com/charmbracelet/lipgloss v0.7.1
	github.com/cli/safeexec v1.0.1
	github.com/codeclysm/extract/v3 v3.1.1
	github.com/coder/flog v1.1.0
	github.com/coder/retry v1.4.0
	github.com/coder/terraform-provider-coder v0.11.1
	github.com/coder/wgtunnel v0.1.5
	github.com/coreos/go-oidc/v3 v3.6.0
	github.com/coreos/go-systemd v0.0.0-20191104093116-d3cd4ed1dbcf
	github.com/creack/pty v1.1.18
	github.com/dave/dst v0.27.2
	github.com/davecgh/go-spew v1.1.1
	github.com/elastic/go-sysinfo v1.11.0
	github.com/fatih/color v1.15.0
	github.com/fatih/structs v1.1.0
	github.com/fatih/structtag v1.2.0
	github.com/fergusstrange/embedded-postgres v1.16.0
	github.com/fullsailor/pkcs7 v0.0.0-20190404230743-d7302db945fa
	github.com/gen2brain/beeep v0.0.0-20220402123239-6a3042f4b71a
	github.com/gliderlabs/ssh v0.3.4
	github.com/go-chi/chi v1.5.4
	github.com/go-chi/chi/v5 v5.0.8
	github.com/go-chi/cors v1.2.1
	github.com/go-chi/httprate v0.7.1
	github.com/go-chi/render v1.0.1
	github.com/go-jose/go-jose/v3 v3.0.0
	github.com/go-logr/logr v1.2.4
	github.com/go-ping/ping v1.1.0
	github.com/go-playground/validator/v10 v10.15.0
	github.com/gofrs/flock v0.8.1
	github.com/gohugoio/hugo v0.116.0
	github.com/golang-jwt/jwt v3.2.2+incompatible
	github.com/golang-jwt/jwt/v4 v4.5.0
	github.com/golang-migrate/migrate/v4 v4.16.0
	github.com/golang/mock v1.6.0
	github.com/google/go-github/v43 v43.0.1-0.20220414155304-00e42332e405
	github.com/google/uuid v1.3.0
	github.com/hashicorp/go-multierror v1.1.1
	github.com/hashicorp/go-reap v0.0.0-20170704170343-bf58d8a43e7b
	github.com/hashicorp/go-version v1.6.0
	github.com/hashicorp/golang-lru/v2 v2.0.1
	github.com/hashicorp/hc-install v0.5.2
	github.com/hashicorp/terraform-config-inspect v0.0.0-20211115214459-90acf1ca460f
	github.com/hashicorp/terraform-json v0.17.0
	github.com/hashicorp/yamux v0.1.1
	github.com/hinshun/vt10x v0.0.0-20220301184237-5011da428d02
	github.com/imulab/go-scim/pkg/v2 v2.2.0
	github.com/jedib0t/go-pretty/v6 v6.4.0
	github.com/jmoiron/sqlx v1.3.5
	github.com/justinas/nosurf v1.1.1
	github.com/kirsle/configdir v0.0.0-20170128060238-e45d2f54772f
	github.com/klauspost/compress v1.16.5
	github.com/lib/pq v1.10.9
	github.com/mattn/go-isatty v0.0.19
	github.com/mitchellh/go-wordwrap v1.0.1
	github.com/mitchellh/mapstructure v1.5.0
	github.com/moby/moby v24.0.1+incompatible
	github.com/muesli/termenv v0.15.2
	github.com/open-policy-agent/opa v0.55.0
	github.com/ory/dockertest/v3 v3.10.0
	github.com/pion/udp v0.1.2
	github.com/pkg/browser v0.0.0-20210911075715-681adbf594b8
	github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e
	github.com/pkg/sftp v1.13.6-0.20221018182125-7da137aa03f0
	github.com/prometheus/client_golang v1.16.0
	github.com/prometheus/client_model v0.4.0
	github.com/prometheus/common v0.42.0
	github.com/quasilyte/go-ruleguard/dsl v0.3.22
	github.com/robfig/cron/v3 v3.0.1
	github.com/spf13/afero v1.9.5
	github.com/spf13/pflag v1.0.5
	github.com/sqlc-dev/pqtype v0.2.0
	github.com/stretchr/testify v1.8.4
	github.com/swaggo/http-swagger/v2 v2.0.1
	github.com/swaggo/swag v1.8.6
	github.com/u-root/u-root v0.11.0
	github.com/unrolled/secure v1.13.0
	github.com/valyala/fasthttp v1.48.0
	github.com/wagslane/go-password-validator v0.3.0
	go.mozilla.org/pkcs7 v0.0.0-20200128120323-432b2356ecb1
	go.nhat.io/otelsql v0.11.0
	go.opentelemetry.io/otel v1.16.0
	go.opentelemetry.io/otel/exporters/otlp/otlptrace v1.16.0
	go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc v1.16.0
	go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp v1.16.0
	go.opentelemetry.io/otel/sdk v1.16.0
	go.opentelemetry.io/otel/trace v1.16.0
	go.uber.org/atomic v1.11.0
	go.uber.org/goleak v1.2.1
	go4.org/netipx v0.0.0-20230728180743-ad4cb58a6516
	golang.org/x/crypto v0.12.0
	golang.org/x/exp v0.0.0-20230801115018-d63ba01acd4b
	golang.org/x/mod v0.12.0
	golang.org/x/net v0.14.0
	golang.org/x/oauth2 v0.11.0
	golang.org/x/sync v0.3.0
	golang.org/x/sys v0.11.0
	golang.org/x/term v0.11.0
	golang.org/x/text v0.12.0
	golang.org/x/tools v0.12.0
	golang.org/x/xerrors v0.0.0-20220907171357-04be3eba64a2
	golang.zx2c4.com/wireguard v0.0.0-20230325221338-052af4a8072b
	google.golang.org/api v0.134.0
	google.golang.org/grpc v1.57.0
	google.golang.org/protobuf v1.31.0
	gopkg.in/natefinch/lumberjack.v2 v2.2.1
	gopkg.in/yaml.v3 v3.0.1
	gvisor.dev/gvisor v0.0.0-20230504175454-7b0a1988a28f
	nhooyr.io/websocket v1.8.7
	storj.io/drpc v0.0.33-0.20230420154621-9716137f6037
)

require (
	github.com/golangci/golangci-lint v1.52.2
	github.com/sqlc-dev/sqlc v1.20.0
	tailscale.com v0.0.0-00010101000000-000000000000
)

require (
	4d63.com/gocheckcompilerdirectives v1.2.1 // indirect
	4d63.com/gochecknoglobals v0.2.1 // indirect
	cloud.google.com/go/compute v1.23.0 // indirect
	cloud.google.com/go/logging v1.7.0 // indirect
	cloud.google.com/go/longrunning v0.5.1 // indirect
	filippo.io/edwards25519 v1.0.0 // indirect
	github.com/Abirdcfly/dupword v0.0.11 // indirect
	github.com/Antonboom/errname v0.1.10 // indirect
	github.com/Antonboom/nilnil v0.1.5 // indirect
	github.com/Azure/go-ansiterm v0.0.0-20230124172434-306776ec8161 // indirect
	github.com/BurntSushi/toml v1.3.0 // indirect
	github.com/Djarvur/go-err113 v0.1.0 // indirect
	github.com/GaijinEntertainment/go-exhaustruct/v2 v2.3.0 // indirect
	github.com/KyleBanks/depth v1.2.1 // indirect
	github.com/Masterminds/semver v1.5.0 // indirect
	github.com/Microsoft/go-winio v0.6.1 // indirect
	github.com/Nvveen/Gotty v0.0.0-20120604004816-cd527374f1e5 // indirect
	github.com/OneOfOne/xxhash v1.2.8 // indirect
	github.com/OpenPeeDeeP/depguard v1.1.1 // indirect
	github.com/ProtonMail/go-crypto v0.0.0-20230426101702-58e86b294756 // indirect
	github.com/agext/levenshtein v1.2.3 // indirect
	github.com/agnivade/levenshtein v1.1.1 // indirect
	github.com/akutz/memconn v0.1.0 // indirect
	github.com/alecthomas/chroma v0.10.0 // indirect
	github.com/alexbrainman/sspi v0.0.0-20210105120005-909beea2cc74 // indirect
	github.com/alexkohler/prealloc v1.0.0 // indirect
	github.com/alingse/asasalint v0.0.11 // indirect
	github.com/anmitsu/go-shlex v0.0.0-20200514113438-38f4b401e2be // indirect
	github.com/antlr/antlr4/runtime/Go/antlr/v4 v4.0.0-20230321174746-8dcc6526cfb1 // indirect
	github.com/apparentlymart/go-textseg/v13 v13.0.0 // indirect
	github.com/armon/go-radix v1.0.0 // indirect
	github.com/ashanbrown/forbidigo v1.5.1 // indirect
	github.com/ashanbrown/makezero v1.1.1 // indirect
	github.com/aws/aws-sdk-go-v2 v1.18.0 // indirect
	github.com/aws/aws-sdk-go-v2/config v1.18.22 // indirect
	github.com/aws/aws-sdk-go-v2/credentials v1.13.21 // indirect
	github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.13.3 // indirect
	github.com/aws/aws-sdk-go-v2/internal/configsources v1.1.33 // indirect
	github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.4.27 // indirect
	github.com/aws/aws-sdk-go-v2/internal/ini v1.3.34 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.9.27 // indirect
	github.com/aws/aws-sdk-go-v2/service/ssm v1.36.3 // indirect
	github.com/aws/aws-sdk-go-v2/service/sso v1.12.9 // indirect
	github.com/aws/aws-sdk-go-v2/service/ssooidc v1.14.9 // indirect
	github.com/aws/aws-sdk-go-v2/service/sts v1.18.10 // indirect
	github.com/aws/smithy-go v1.13.5 // indirect
	github.com/aymanbagabas/go-osc52/v2 v2.0.1 // indirect
	github.com/aymerick/douceur v0.2.0 // indirect
	github.com/benbjohnson/clock v1.1.0 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/bep/godartsass v1.2.0 // indirect
	github.com/bep/godartsass/v2 v2.0.0 // indirect
	github.com/bep/golibsass v1.1.1 // indirect
	github.com/bkielbasa/cyclop v1.2.0 // indirect
	github.com/blizzy78/varnamelen v0.8.0 // indirect
	github.com/bombsimon/wsl/v3 v3.4.0 // indirect
	github.com/breml/bidichk v0.2.4 // indirect
	github.com/breml/errchkjson v0.3.1 // indirect
	github.com/butuzov/ireturn v0.2.0 // indirect
	github.com/bytecodealliance/wasmtime-go/v8 v8.0.0 // indirect
	github.com/cespare/xxhash/v2 v2.2.0 // indirect
	github.com/charithe/durationcheck v0.0.10 // indirect
	github.com/charmbracelet/bubbles v0.15.0 // indirect
	github.com/charmbracelet/bubbletea v0.23.2 // indirect
	github.com/chavacava/garif v0.0.0-20230227094218-b8c73b2037b8 // indirect
	github.com/clbanning/mxj/v2 v2.5.7 // indirect
	github.com/cloudflare/circl v1.3.3 // indirect
	github.com/containerd/console v1.0.3 // indirect
	github.com/containerd/continuity v0.4.1 // indirect
	github.com/coreos/go-iptables v0.6.0 // indirect
	github.com/cubicdaiya/gonp v1.0.4 // indirect
	github.com/curioswitch/go-reassign v0.2.0 // indirect
	github.com/cznic/mathutil v0.0.0-20181122101859-297441e03548 // indirect
	github.com/daixiang0/gci v0.10.1 // indirect
	github.com/denis-tingaikin/go-header v0.4.3 // indirect
	github.com/dlclark/regexp2 v1.10.0 // indirect
	github.com/docker/cli v23.0.5+incompatible // indirect
	github.com/docker/docker v23.0.5+incompatible // indirect
	github.com/docker/go-connections v0.4.0 // indirect
	github.com/docker/go-units v0.5.0 // indirect
	github.com/elastic/go-windows v1.0.0 // indirect
	github.com/esimonov/ifshort v1.0.4 // indirect
	github.com/ettle/strcase v0.1.1 // indirect
	github.com/firefart/nonamedreturns v1.0.4 // indirect
	github.com/fsnotify/fsnotify v1.6.0 // indirect
	github.com/fxamacker/cbor/v2 v2.4.0 // indirect
	github.com/fzipp/gocyclo v0.6.0 // indirect
	github.com/gabriel-vasile/mimetype v1.4.2 // indirect
	github.com/ghodss/yaml v1.0.0 // indirect
	github.com/gin-gonic/gin v1.9.1 // indirect
	github.com/go-critic/go-critic v0.8.1 // indirect
	github.com/go-ini/ini v1.67.0 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-ole/go-ole v1.2.6 // indirect
	github.com/go-openapi/jsonpointer v0.19.6 // indirect
	github.com/go-openapi/jsonreference v0.20.2 // indirect
	github.com/go-openapi/spec v0.20.6 // indirect
	github.com/go-openapi/swag v0.22.3 // indirect
	github.com/go-playground/locales v0.14.1 // indirect
	github.com/go-playground/universal-translator v0.18.1 // indirect
	github.com/go-sql-driver/mysql v1.7.1 // indirect
	github.com/go-test/deep v1.0.8 // indirect
	github.com/go-toast/toast v0.0.0-20190211030409-01e6764cf0a4 // indirect
	github.com/go-toolsmith/astcast v1.1.0 // indirect
	github.com/go-toolsmith/astcopy v1.1.0 // indirect
	github.com/go-toolsmith/astequal v1.1.0 // indirect
	github.com/go-toolsmith/astfmt v1.1.0 // indirect
	github.com/go-toolsmith/astp v1.1.0 // indirect
	github.com/go-toolsmith/strparse v1.1.0 // indirect
	github.com/go-toolsmith/typep v1.1.0 // indirect
	github.com/go-xmlfmt/xmlfmt v1.1.2 // indirect
	github.com/gobwas/glob v0.2.3 // indirect
	github.com/gobwas/ws v1.1.0 // indirect
	github.com/godbus/dbus/v5 v5.1.0 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/glog v1.1.0 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/golangci/check v0.0.0-20180506172741-cfe4005ccda2 // indirect
	github.com/golangci/dupl v0.0.0-20180902072040-3e9179ac440a // indirect
	github.com/golangci/go-misc v0.0.0-20220329215616-d24fe342adfe // indirect
	github.com/golangci/gofmt v0.0.0-20220901101216-f2edd75033f2 // indirect
	github.com/golangci/lint-1 v0.0.0-20191013205115-297bf364a8e0 // indirect
	github.com/golangci/maligned v0.0.0-20180506175553-b1d89398deca // indirect
	github.com/golangci/misspell v0.4.0 // indirect
	github.com/golangci/revgrep v0.0.0-20220804021717-745bb2f7c2e6 // indirect
	github.com/golangci/unconvert v0.0.0-20180507085042-28b1c447d1f4 // indirect
	github.com/google/btree v1.1.2 // indirect
	github.com/google/cel-go v0.17.1 // indirect
	github.com/google/flatbuffers v23.1.21+incompatible // indirect
	github.com/google/go-cmp v0.5.9 // indirect
	github.com/google/go-querystring v1.1.0 // indirect
	github.com/google/nftables v0.1.1-0.20230115205135-9aa6fdf5a28c // indirect
	github.com/google/s2a-go v0.1.4 // indirect
	github.com/google/shlex v0.0.0-20191202100458-e7afc7fbc510 // indirect
	github.com/googleapis/enterprise-certificate-proxy v0.2.5 // indirect
	github.com/gordonklaus/ineffassign v0.0.0-20230107090616-13ace0543b28 // indirect
	github.com/gorilla/css v1.0.0 // indirect
	github.com/gorilla/mux v1.8.0 // indirect
	github.com/gostaticanalysis/analysisutil v0.7.1 // indirect
	github.com/gostaticanalysis/comment v1.4.2 // indirect
	github.com/gostaticanalysis/forcetypeassert v0.1.0 // indirect
	github.com/gostaticanalysis/nilerr v0.1.1 // indirect
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.15.1 // indirect
	github.com/h2non/filetype v1.1.3 // indirect
	github.com/hashicorp/errwrap v1.1.0 // indirect
	github.com/hashicorp/go-cleanhttp v0.5.2 // indirect
	github.com/hashicorp/go-cty v1.4.1-0.20200414143053-d3edf31b6320 // indirect
	github.com/hashicorp/go-hclog v1.2.1 // indirect
	github.com/hashicorp/go-uuid v1.0.3 // indirect
	github.com/hashicorp/hcl v1.0.0 // indirect
	github.com/hashicorp/hcl/v2 v2.17.0 // indirect
	github.com/hashicorp/logutils v1.0.0 // indirect
	github.com/hashicorp/terraform-plugin-go v0.12.0 // indirect
	github.com/hashicorp/terraform-plugin-log v0.7.0 // indirect
	github.com/hashicorp/terraform-plugin-sdk/v2 v2.20.0 // indirect
	github.com/hdevalence/ed25519consensus v0.1.0 // indirect
	github.com/hexops/gotextdiff v1.0.3 // indirect
	github.com/illarion/gonotify v1.0.1 // indirect
	github.com/imdario/mergo v0.3.15 // indirect
	github.com/inconshreveable/mousetrap v1.1.0 // indirect
	github.com/insomniacslk/dhcp v0.0.0-20230407062729-974c6f05fe16 // indirect
	github.com/jackc/pgpassfile v1.0.0 // indirect
	github.com/jackc/pgservicefile v0.0.0-20221227161230-091c0ba34f0a // indirect
	github.com/jackc/pgx/v5 v5.4.2 // indirect
	github.com/jgautheron/goconst v1.5.1 // indirect
	github.com/jingyugao/rowserrcheck v1.1.1 // indirect
	github.com/jinzhu/inflection v1.0.0 // indirect
	github.com/jirfag/go-printf-func-name v0.0.0-20200119135958-7558a9eaa5af // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/joeshaw/multierror v0.0.0-20140124173710-69b34d4ec901 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/josharian/native v1.1.1-0.20230202152459-5c7d0dd6ab86 // indirect
	github.com/jsimonetti/rtnetlink v1.3.2 // indirect
	github.com/juju/errors v1.0.0 // indirect
	github.com/julz/importas v0.1.0 // indirect
	github.com/junk1tm/musttag v0.5.0 // indirect
	github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51 // indirect
	github.com/kisielk/errcheck v1.6.3 // indirect
	github.com/kisielk/gotool v1.0.0 // indirect
	github.com/kkHAIKE/contextcheck v1.1.4 // indirect
	github.com/kortschak/wol v0.0.0-20200729010619-da482cc4850a // indirect
	github.com/kr/fs v0.1.0 // indirect
	github.com/kulti/thelper v0.6.3 // indirect
	github.com/kunwardeep/paralleltest v1.0.7 // indirect
	github.com/kyoh86/exportloopref v0.1.11 // indirect
	github.com/ldez/gomoddirectives v0.2.3 // indirect
	github.com/ldez/tagliatelle v0.5.0 // indirect
	github.com/leodido/go-urn v1.2.4 // indirect
	github.com/leonklingele/grouper v1.1.1 // indirect
	github.com/lucasb-eyer/go-colorful v1.2.0 // indirect
	github.com/lufeee/execinquery v1.2.1 // indirect
	github.com/magiconair/properties v1.8.7 // indirect
	github.com/mailru/easyjson v0.7.7 // indirect
	github.com/maratori/testableexamples v1.0.0 // indirect
	github.com/maratori/testpackage v1.1.1 // indirect
	github.com/matoous/godox v0.0.0-20230222163458-006bad1f9d26 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-localereader v0.0.1 // indirect
	github.com/mattn/go-runewidth v0.0.15 // indirect
	github.com/mattn/go-sqlite3 v1.14.17 // indirect
	github.com/matttproud/golang_protobuf_extensions v1.0.4 // indirect
	github.com/mbilski/exhaustivestruct v1.2.0 // indirect
	github.com/mdlayher/genetlink v1.3.2 // indirect
	github.com/mdlayher/netlink v1.7.2 // indirect
	github.com/mdlayher/sdnotify v1.0.0 // indirect
	github.com/mdlayher/socket v0.4.1 // indirect
	github.com/mgechev/revive v1.3.2 // indirect
	github.com/mgutz/ansi v0.0.0-20170206155736-9520e82c474b // indirect
	github.com/microcosm-cc/bluemonday v1.0.23 // indirect
	github.com/miekg/dns v1.1.55 // indirect
	github.com/mitchellh/copystructure v1.2.0 // indirect
	github.com/mitchellh/go-homedir v1.1.0 // indirect
	github.com/mitchellh/go-ps v1.0.0 // indirect
	github.com/mitchellh/go-testing-interface v1.14.1 // indirect
	github.com/mitchellh/reflectwalk v1.0.2 // indirect
	github.com/moby/term v0.5.0 // indirect
	github.com/moricho/tparallel v0.3.1 // indirect
	github.com/muesli/ansi v0.0.0-20221106050444-61f0cd9a192a // indirect
	github.com/muesli/cancelreader v0.2.2 // indirect
	github.com/muesli/reflow v0.3.0 // indirect
	github.com/nakabonne/nestif v0.3.1 // indirect
	github.com/nbutton23/zxcvbn-go v0.0.0-20210217022336-fa2cb2858354 // indirect
	github.com/niklasfasching/go-org v1.7.0 // indirect
	github.com/nishanths/exhaustive v0.10.0 // indirect
	github.com/nishanths/predeclared v0.2.2 // indirect
	github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d // indirect
	github.com/nunnatsa/ginkgolinter v0.12.0 // indirect
	github.com/olekukonko/tablewriter v0.0.5 // indirect
	github.com/opencontainers/go-digest v1.0.0 // indirect
	github.com/opencontainers/image-spec v1.1.0-rc4 // indirect
	github.com/opencontainers/runc v1.1.5 // indirect
	github.com/pelletier/go-toml/v2 v2.0.8 // indirect
	github.com/pganalyze/pg_query_go/v4 v4.2.1 // indirect
	github.com/pierrec/lz4/v4 v4.1.17 // indirect
	github.com/pingcap/errors v0.11.5-0.20210425183316-da1aaba5fb63 // indirect
	github.com/pingcap/log v0.0.0-20210906054005-afc726e70354 // indirect
	github.com/pingcap/tidb/parser v0.0.0-20220725134311-c80026e61f00 // indirect
	github.com/pion/transport v0.14.1 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/polyfloyd/go-errorlint v1.4.2 // indirect
	github.com/prometheus/procfs v0.10.1 // indirect
	github.com/quasilyte/go-ruleguard v0.3.19 // indirect
	github.com/quasilyte/gogrep v0.5.0 // indirect
	github.com/quasilyte/regex/syntax v0.0.0-20210819130434-b3f0c404a727 // indirect
	github.com/quasilyte/stdinfo v0.0.0-20220114132959-f7386bf02567 // indirect
	github.com/rcrowley/go-metrics v0.0.0-20200313005456-10cdbea86bc0 // indirect
	github.com/remyoudompheng/bigfft v0.0.0-20200410134404-eec4a21b6bb0 // indirect
	github.com/rivo/uniseg v0.4.4 // indirect
	github.com/riza-io/grpc-go v0.2.0 // indirect
	github.com/ryancurrah/gomodguard v1.3.0 // indirect
	github.com/ryanrolds/sqlclosecheck v0.4.0 // indirect
	github.com/sanposhiho/wastedassign/v2 v2.0.7 // indirect
	github.com/sashamelentyev/interfacebloat v1.1.0 // indirect
	github.com/sashamelentyev/usestdlibvars v1.23.0 // indirect
	github.com/satori/go.uuid v1.2.1-0.20181028125025-b2ce2384e17b // indirect
	github.com/securego/gosec/v2 v2.16.0 // indirect
	github.com/shazow/go-diff v0.0.0-20160112020656-b6b7b6733b8c // indirect
	github.com/sirupsen/logrus v1.9.3 // indirect
	github.com/sivchari/containedctx v1.0.3 // indirect
	github.com/sivchari/nosnakecase v1.7.0 // indirect
	github.com/sivchari/tenv v1.7.1 // indirect
	github.com/sonatard/noctx v0.0.2 // indirect
	github.com/sourcegraph/go-diff v0.7.0 // indirect
	github.com/spf13/cast v1.5.1 // indirect
	github.com/spf13/cobra v1.7.0 // indirect
	github.com/spf13/jwalterweatherman v1.1.0 // indirect
	github.com/spf13/viper v1.15.0 // indirect
	github.com/ssgreg/nlreturn/v2 v2.2.1 // indirect
	github.com/stbenjam/no-sprintf-host-port v0.1.1 // indirect
	github.com/stoewer/go-strcase v1.2.0 // indirect
	github.com/stretchr/objx v0.5.0 // indirect
	github.com/subosito/gotenv v1.4.2 // indirect
	github.com/swaggo/files/v2 v2.0.0 // indirect
	github.com/t-yuki/gocover-cobertura v0.0.0-20180217150009-aaee18c8195c // indirect
	github.com/tadvi/systray v0.0.0-20190226123456-11a2b8fa57af // indirect
	github.com/tailscale/certstore v0.1.1-0.20220316223106-78d6e1c49d8d // indirect
	github.com/tailscale/golang-x-crypto v0.0.0-20230713185742-f0b76a10a08e // indirect
	github.com/tailscale/goupnp v1.0.1-0.20210804011211-c64d0f06ea05 // indirect
	github.com/tailscale/netlink v1.1.1-0.20211101221916-cabfb018fe85 // indirect
	github.com/tailscale/wireguard-go v0.0.0-20230710185534-bb2c8f22eccf // indirect
	github.com/tchap/go-patricia/v2 v2.3.1 // indirect
	github.com/tcnksm/go-httpstat v0.2.0 // indirect
	github.com/tdakkota/asciicheck v0.2.0 // indirect
	github.com/tdewolff/parse/v2 v2.6.6 // indirect
	github.com/tdewolff/test v1.0.9 // indirect
	github.com/tetafro/godot v1.4.11 // indirect
	github.com/timakin/bodyclose v0.0.0-20230421092635-574207250966 // indirect
	github.com/timonwong/loggercheck v0.9.4 // indirect
	github.com/tomarrell/wrapcheck/v2 v2.8.1 // indirect
	github.com/tommy-muehle/go-mnd/v2 v2.5.1 // indirect
	github.com/u-root/uio v0.0.0-20230305220412-3e8cd9d6bf63 // indirect
	github.com/ulikunitz/xz v0.5.11 // indirect
	github.com/ultraware/funlen v0.0.3 // indirect
	github.com/ultraware/whitespace v0.0.5 // indirect
	github.com/uudashr/gocognit v1.0.6 // indirect
	github.com/vishvananda/netlink v1.2.1-beta.2 // indirect
	github.com/vishvananda/netns v0.0.4 // indirect
	github.com/vmihailenco/msgpack v4.0.4+incompatible // indirect
	github.com/vmihailenco/msgpack/v4 v4.3.12 // indirect
	github.com/vmihailenco/tagparser v0.1.1 // indirect
	github.com/x448/float16 v0.8.4 // indirect
	github.com/xeipuuv/gojsonpointer v0.0.0-20190905194746-02993c407bfb // indirect
	github.com/xeipuuv/gojsonreference v0.0.0-20180127040603-bd5ef7bd5415 // indirect
	github.com/xeipuuv/gojsonschema v1.2.0 // indirect
	github.com/xi2/xz v0.0.0-20171230120015-48954b6210f8 // indirect
	github.com/yagipy/maintidx v1.0.0 // indirect
	github.com/yashtewari/glob-intersection v0.2.0 // indirect
	github.com/yeya24/promlinter v0.2.0 // indirect
	github.com/yuin/goldmark v1.5.5 // indirect
	github.com/yuin/goldmark-emoji v1.0.1 // indirect
	github.com/zclconf/go-cty v1.13.2 // indirect
	github.com/zeebo/errs v1.3.0 // indirect
	gitlab.com/bosi/decorder v0.2.3 // indirect
	go.opencensus.io v0.24.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/internal/retry v1.16.0 // indirect
	go.opentelemetry.io/otel/metric v1.16.0 // indirect
	go.opentelemetry.io/proto/otlp v0.19.0 // indirect
	go.uber.org/multierr v1.11.0 // indirect
	go.uber.org/zap v1.24.0 // indirect
	go4.org/mem v0.0.0-20220726221520-4f986261bf13 // indirect
	golang.org/x/exp/typeparams v0.0.0-20230425010034-47ecfdc1ba53 // indirect
	golang.org/x/time v0.3.0 // indirect
	golang.zx2c4.com/wintun v0.0.0-20230126152724-0fa3db229ce2 // indirect
	golang.zx2c4.com/wireguard/wgctrl v0.0.0-20230215201556-9c5414ab4bde // indirect
	golang.zx2c4.com/wireguard/windows v0.5.3 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	google.golang.org/genproto v0.0.0-20230726155614-23370e0ffb3e // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20230706204954-ccb25ca9f130 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20230720185612-659f7aaaa771 // indirect
	gopkg.in/ini.v1 v1.67.0 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	honnef.co/go/tools v0.4.3 // indirect
	howett.net/plist v1.0.0 // indirect
	inet.af/peercred v0.0.0-20210906144145-0893ea02156a // indirect
	mvdan.cc/gofumpt v0.5.0 // indirect
	mvdan.cc/interfacer v0.0.0-20180901003855-c20040233aed // indirect
	mvdan.cc/lint v0.0.0-20170908181259-adc824a0674b // indirect
	mvdan.cc/unparam v0.0.0-20230312165513-e84e2d14e3b8 // indirect
)
