FROM golang:latest AS builder

RUN apk update && apk add --no-cache git

WORKDIR $GOPATH/src/efishery/

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -o /go/bin/demo

FROM alpine:latest

RUN apk add --no-cache tzdata

COPY --from=builder /go/bin/demo /go/bin/demo

ENTRYPOINT ["/go/bin/demo"]