FROM golang:1.9-alpine
WORKDIR /go/src/github.com/drone-plugins/drone-slack
ADD . .
RUN GOOS=linux CGO_ENABLED=0 go build -o /bin/drone-slack \
    github.com/drone-plugins/drone-slack

FROM alpine:3.7
RUN apk add --no-cache ca-certificates
COPY --from=0 /bin/drone-slack /bin/drone-slack
ENTRYPOINT ["/bin/drone-slack"]
