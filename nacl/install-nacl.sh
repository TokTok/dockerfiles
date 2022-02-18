#!/bin/sh

set -eux

NACL=nacl-20110221

curl "https://hyperelliptic.org/nacl/$NACL.tar.bz2" | tar jx
cd "$NACL" # pushd
"./do"
# "make install"
mkdir -p "$CACHEDIR/include"
mv build/*/include/* "$CACHEDIR/include"
mkdir -p "$CACHEDIR/lib"
mv build/*/lib/* "$CACHEDIR/lib"
cd - # popd
rm -rf "$NACL"
