FROM golang:latest AS build

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /build

COPY go.mod go.sum /build/
RUN go mod download

COPY . .

RUN go build -ldflags '-s -w' -v .

FROM scratch
WORKDIR /

COPY --from=build /build/auto-spf-flattener /auto-spf-flattener

ENTRYPOINT ["/auto-spf-flattener"]
