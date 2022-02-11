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

WORKDIR /github
RUN useradd \
 --home-dir /github/home \
 --create-home \
 --gid users \
 --groups sudo \
 --uid 1001 \
 builder \
 && mkdir /work && chown builder:users /work \
 && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder

COPY --chown=builder:users stack.yaml /github/home/.stack/global-project/
RUN ["stack", "install", "base"]
