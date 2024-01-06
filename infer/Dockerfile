FROM ubuntu:22.04

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 autoconf \
 automake \
 ca-certificates \
 cmake \
 curl \
 git \
 libconfig-dev \
 libgmp-dev \
 libopus-dev \
 libsodium-dev \
 libsqlite3-dev \
 libvpx-dev \
 opam \
 ninja-build \
 pkg-config \
 python3 \
 sqlite3 \
 zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# https://github.com/facebook/infer/blob/main/INSTALL.md#install-infer-from-source
RUN git clone --depth=1 https://github.com/facebook/infer.git /work/infer
WORKDIR /work/infer
RUN yes | ./build-infer.sh clang && make install && rm -rf /work/infer/*
