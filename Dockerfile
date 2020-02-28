FROM golang:1.14 as builder

COPY . /app
WORKDIR /app

RUN export GIT_TAG=$(git describe --abbrev=0 --tags) && \
    export GIT_HASH=$(git log --pretty=format:'%h' -n 1) && \
    export GO_VERSION=$(go version | awk '{print $3}') && \
    export BUILD_DATE=$(date -u +"%Y-%m-%d_%H:%M:%S_UTC") && \
    export GO_HOSTOS=$(go env GOHOSTOS) && \
    export GO_HOSTARCH=$(go env GOHOSTARCH) && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo -ldflags "-w --extldflags '-static' -X main.appName=appver -X main.appVersion=$GIT_TAG -X main.appCommitHash=$GIT_HASH -X main.goVersion=$GO_VERSION -X main.buildDate=$BUILD_DATE -X main.buildArch=$GO_HOSTOS/$GO_HOSTARCH" -o bin/appver main.go

FROM alpine:3.11
COPY --from=builder /app/bin/appver /app/appver
CMD ["/app/appver"]
