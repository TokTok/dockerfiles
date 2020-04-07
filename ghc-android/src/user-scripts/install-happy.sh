#!/bin/bash

. set-env-android.sh
####################################################################################################

# install a cabal that supports cross compilation
mkdir -p "$HOME/.cabal/bin"
cabal v1-install alex happy --bindir="$GHC_STAGE0_PREFIX/bin/"

rm -rf "${BASH_SOURCE[0]}"
