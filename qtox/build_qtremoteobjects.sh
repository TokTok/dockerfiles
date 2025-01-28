#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qtremoteobjects" --supported "linux-x86_64 macos-arm64 macos-x86_64 win32 win64" "$@"

"$SCRIPT_DIR/download/download_qtremoteobjects.sh"

mkdir _build && pushd _build
"$QT_PREFIX/bin/qt-configure-module" .. \
  -- \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -DCMAKE_CXX_FLAGS="-DQT_MESSAGELOGCONTEXT" \
  -Wno-dev
cmake --build .
cmake --install .
popd
