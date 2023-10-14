FROM ubuntu:22.04

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 ca-certificates \
 curl \
 git \
 python3 \
 python3-dev \
 sudo \
 xz-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN curl -Lo /usr/local/bin/bazel https://github.com/bazelbuild/bazelisk/releases/download/v1.18.0/bazelisk-linux-amd64 \
 && chmod 755 /usr/local/bin/bazel

WORKDIR /src/workspace
RUN useradd -m -g users -G sudo -u 1000 builder \
 && chown builder:users /src/workspace \
 && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder

RUN curl -Lo install.sh https://nixos.org/nix/install \
 && sh install.sh --no-daemon --no-channel-add --yes \
 && rm install.sh

ENV NIX_SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt" \
    NIX_PROFILES="/nix/var/nix/profiles/default /home/builder/.nix-profile" \
    PATH="/home/builder/.nix-profile/bin:$PATH"
