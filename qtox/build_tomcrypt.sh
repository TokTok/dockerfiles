#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "tomcrypt" --supported "linux-aarch64 linux-x86_64 win32 win64 macos-x86_64 macos-arm64 ios-arm64 ios-armv7 ios-armv7s ios-i386 ios-x86_64 wasm" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  MAKEFILE="makefile.shared"
else
  MAKEFILE="makefile"
fi

"$SCRIPT_DIR/download/download_tomcrypt.sh"

"${EMMAKE[@]}" make -j "$MAKE_JOBS" -f "$MAKEFILE" library
"${EMMAKE[@]}" make install PREFIX="$DEP_PREFIX"
