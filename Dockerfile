FROM golang:1.14 as builder

COPY . /app
WORKDIR /app

RUN GIT_TAG=$(git describe --abbrev=0 --tags) \
    GIT_HASH=$(git rev-list -1 HEAD) \
    GO_VERSION=$(go version | awk '{print $3}') \
    BUILD_DATE=$(date -u) \
    go build -o bin/appver -ldflags "-X main.appName=appver -X main.appVersion=$GIT_TAG -X main.appCommitHash=$GIT_HASH -X main.goVersion=$GO_VERSION -X main.buildDate=$BUILD_DATE -X main.buildArch=$GOHOSTOS/$GOHOSTARCH"

FROM alpine:3.11
COPY --from=builder /app/bin/appver /app/appver
CMD ["/app/appver"]
