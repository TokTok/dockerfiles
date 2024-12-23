let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/a81bbdfb658428a45c69a42aa73d4bd18127c467.tar.gz";
    sha256 = "sha256:0vzjqdi39n7l43lzz2w6fv8p112iyj752x68gmjxw2y10cgk0352";
  };
in
(import nixpkgs { system = "x86_64-linux"; }).pkgs
