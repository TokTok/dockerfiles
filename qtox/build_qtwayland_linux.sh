#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qtwayland" --supported "linux-x86_64" "$@"

"$SCRIPT_DIR/download/download_qtwayland.sh"

export CXXFLAGS="-DQT_MESSAGELOGCONTEXT"
export OBJCXXFLAGS="$CXXFLAGS"

mkdir _build && pushd _build
"$QT_PREFIX/bin/qt-configure-module" .. \
  -- \
  -Wno-dev
cmake --build .
cmake --install .
popd
