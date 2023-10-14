# This is the version that comes with nixpkgs 23.05.
FROM nixos/nix:2.13.3

# Get the sources of the same version of nix as the source image.
RUN ["git", "clone", "--depth=1", "--branch=2.13.3", "https://github.com/NixOS/nix", "/root/nix"]
WORKDIR /root/nix
RUN ["nix-build", "docker.nix",\
 "--arg", "name", "\"toxchat/nix\"",\
 "--arg", "maxLayers", "2",\
 "--arg", "channelURL", "https://nixos.org/channels/nixos-23.05",\
 "--arg", "pkgs", "let nixpkgs = fetchTarball { url = \"https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05.tar.gz\"; sha256 = \"10wn0l08j9lgqcw8177nh2ljrnxdrpri7bp0g7nvrsn9rkawvlbf\"; }; in import nixpkgs { }",\
 "-o", "nix.tar.gz"]
