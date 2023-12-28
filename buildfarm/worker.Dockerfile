FROM bazelbuild/buildfarm-worker:2.8.0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update \
 && apt-get install --no-install-recommends -y curl sudo \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ubuntu
ENV USER=ubuntu

RUN sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-channel-add --yes
RUN . "$HOME/.nix-profile/etc/profile.d/nix.sh" \
 && nix-channel --add https://github.com/NixOS/nixpkgs/archive/refs/tags/23.11.tar.gz nixpkgs \
 && nix-channel --update

WORKDIR /home/ubuntu
COPY default.nix /home/ubuntu
RUN . "$HOME/.nix-profile/etc/profile.d/nix.sh" \
 && nix-build

COPY config.yml /app/build_buildfarm/examples/config.minimal.yml
