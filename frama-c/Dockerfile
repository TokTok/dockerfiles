FROM ubuntu:22.04

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 autoconf \
 ca-certificates \
 git \
 graphviz \
 libgtksourceview-3.0-dev \
 libopus-dev \
 libsodium-dev \
 libvpx-dev \
 opam \
 pkg-config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN opam init --disable-sandboxing --compiler 4.14.1
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 libgmp-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN eval "$(opam env)" \
 && opam install -y frama-c.27.1
COPY linux /home/builder/include/linux
