FROM golang:1.16-alpine AS build

# Install bazel-remote.
RUN go get github.com/buchgr/bazel-remote

# Produce a minimal image with just the bazel-remote binary.
FROM alpine:3.15.0
COPY --from=build /go/bin/bazel-remote /

WORKDIR /cache
RUN ["chown", "1000:1000", "/cache"]
USER 1000
ENTRYPOINT ["/bazel-remote", "--port", "9090", "--dir", "/cache", "--max_size", "10"]

EXPOSE 9090/tcp
EXPOSE 9092/tcp
