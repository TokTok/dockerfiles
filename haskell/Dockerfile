# Don't upgrade this until render.com runs a newer ubuntu.
# Otherwise, glibc won't be recent enough and our binaries won't run.
FROM ubuntu:20.04

# Retry downloads that fail for a moment, e.g. GitHub's occasional HTTP 500.
# The settings apply while building this image, not in the image itself.
ARG CURL_HOME=/etc/download-retry
ARG WGETRC=/etc/download-retry/wgetrc
RUN mkdir -p /etc/download-retry \
 && printf 'retry = 5\nretry-delay = 10\nretry-connrefused\nretry-all-errors\nfail\n' >/etc/download-retry/.curlrc \
 && printf 'tries = 5\nwaitretry = 10\nretry_connrefused = on\nretry_on_http_error = 429,500,502,503,504\n' >/etc/download-retry/wgetrc

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
 ca-certificates \
 cmake \
 curl \
 git \
 libavcodec-dev \
 libmsgpack-dev \
 libopus-dev \
 libsodium-dev \
 libtinfo-dev \
 libvpx-dev \
 ninja-build \
 pkg-config \
 sudo \
 && curl -sSL -o /tmp/install-stack.sh https://get.haskellstack.org/ \
 && sh /tmp/install-stack.sh \
 && rm /tmp/install-stack.sh \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work
RUN useradd \
 --create-home \
 --gid users \
 --groups sudo \
 --uid 1001 \
 builder \
 && chown builder:users /work \
 && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder
RUN mkdir /tmp/cirrus-ci-build

ENV STACK_ROOT=/.stack

COPY --chown=builder:users stack.yaml $STACK_ROOT/global-project/
# hadolint ignore=DL3003
RUN git clone --depth=1 --recurse-submodules --shallow-submodules https://github.com/TokTok/toktok-stack /work/toktok-stack \
 && cd /work/toktok-stack \
 && stack build --test --only-dependencies \
 && rm -rf /work/toktok-stack
