# Don't upgrade this until render.com runs a newer ubuntu.
# Otherwise, glibc won't be recent enough and our binaries won't run.
FROM ubuntu:20.04

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
 ca-certificates \
 cmake \
 curl \
 git \
 libmsgpack-dev \
 libopus-dev \
 libsodium-dev \
 libtinfo-dev \
 libvpx-dev \
 ninja-build \
 pkg-config \
 sudo \
 && curl -sSL https://get.haskellstack.org/ | sh \
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
