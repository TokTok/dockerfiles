let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/3a7affa77a5a539afa1c7859e2c31abdb1aeadf3.tar.gz";
    sha256 = "sha256:0bzpgy08ym73g6z9wk3pmsbygv0kq46s6dfc7jwmrh3s5iwngrdf";
  };
in
(import nixpkgs { system = "x86_64-linux"; }).pkgs
