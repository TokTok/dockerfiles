#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

set -x

$THIS_DIR/download-ghc.sh
$THIS_DIR/build-ghc-host.sh
$THIS_DIR/build-ghc-cross-compiler.sh

rm -rf ${BASH_SOURCE[0]} "$GHC_TAR_PATH"
