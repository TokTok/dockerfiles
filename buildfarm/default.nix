with (import <nixpkgs> { });

pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    bazel
    clang
    perl
  ];
}
