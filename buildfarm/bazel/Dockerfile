FROM alpine:3.18.2

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add \
 bazel \
 coreutils \
 ca-certificates \
 curl \
 git \
 python3 \
 python3-dev \
 sudo \
 xz

WORKDIR /src/workspace
RUN adduser -D -G users -u 1000 builder \
 && chown builder:users /src/workspace \
 && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder

RUN curl -Lo install.sh https://nixos.org/nix/install \
 && sh install.sh --no-daemon --no-channel-add --yes \
 && rm install.sh

ENV NIX_SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt" \
    NIX_PROFILES="/nix/var/nix/profiles/default /home/builder/.nix-profile" \
    PATH="/home/builder/.nix-profile/bin:$PATH"
