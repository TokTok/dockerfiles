let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/2786a2a72088ecf32aea5b3ec52099e6a7cff78f.tar.gz";
    sha256 = "sha256:0fm3lxj743j3ksdhs31lb2sn9bkix3kvam2qb4hc8ipr2yzmbxbz";
  };
in
(import nixpkgs { system = "x86_64-linux"; }).pkgs
