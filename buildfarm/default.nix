with (import <nixpkgs> { });

pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    bazel
    clang
    jdk11.home
    perl
  ];
}
