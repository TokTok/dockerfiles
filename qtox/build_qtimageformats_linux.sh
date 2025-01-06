#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qtimageformats" --supported "linux-x86_64" "$@"

"$SCRIPT_DIR/download/download_qtimageformats.sh"

export CXXFLAGS="-DQT_MESSAGELOGCONTEXT"
export OBJCXXFLAGS="$CXXFLAGS"

mkdir qtimageformats/_build && pushd qtimageformats/_build
"$DEP_PREFIX/qt/bin/qt-configure-module" .. \
  -- \
  -Wno-dev
cmake --build .
cmake --install .
popd
