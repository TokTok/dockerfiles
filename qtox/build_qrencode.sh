#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
#     Copyright (c) 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
#     Copyright (c) 2021 by The qTox Project Contributors

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qrencode" --supported "win32 win64 macos macos-x86_64 macos-arm64" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  BUILD_SHARED_LIBS=ON
else
  BUILD_SHARED_LIBS=OFF
fi

"$SCRIPT_DIR/download/download_qrencode.sh"

cmake . \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="$MACOS_MINIMUM_SUPPORTED_VERSION" \
  "$CMAKE_TOOLCHAIN_FILE" \
  -DWITH_TOOLS=OFF \
  -DBUILD_SHARED_LIBS="$BUILD_SHARED_LIBS"

make -j "$MAKE_JOBS"
make install
