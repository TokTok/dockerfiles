#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "extra-cmake-modules" --supported "linux win32 win64 macos macos-x86_64 macos-arm64" "$@"

"$SCRIPT_DIR/download/download_extra_cmake_modules.sh"

cmake -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_TESTING=OFF \
  -GNinja \
  -B_build \
  .
cmake --build _build
cmake --install _build
