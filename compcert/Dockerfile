FROM ubuntu:20.04

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 ca-certificates \
 coq \
 curl \
 git \
 libconfig-dev \
 libmenhir-ocaml-dev \
 libmsgpack-dev \
 libopus-dev \
 libsodium-dev \
 libvpx-dev \
 make \
 menhir \
 ocaml-nox \
 pkg-config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /home/builder
RUN ["git", "clone", "--depth=1", "https://github.com/AbsInt/CompCert"]

WORKDIR /home/builder/CompCert
RUN ["./configure", "x86_64-linux"]

RUN ["make", "-j4"]
RUN ["make", "install"]
WORKDIR /home/builder
