{
  description = "TokTok bazel container";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs, ... }: {
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  };
}
