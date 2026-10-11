let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/9fbb54b33e91ee4ca368e35a78e0613c720600b3.tar.gz";
    sha256 = "sha256:0q7588a893rijgzwpcba5q72cjzmha4pgi6aaghipp2aj8872pki";
  };
in
(import nixpkgs { system = "x86_64-linux"; }).pkgs
