#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qt" --supported "win32 win64" "$@"

"$SCRIPT_DIR/download/download_qtimageformats.sh"

mkdir qtimageformats/_build && pushd qtimageformats/_build
"$DEP_PREFIX/bin/qt-configure-module" .. \
  -- \
  -DCMAKE_CXX_FLAGS="-DQT_MESSAGELOGCONTEXT" \
  -Wno-dev
cmake --build .
cmake --install .
popd
