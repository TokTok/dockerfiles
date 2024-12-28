#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qttools" --supported "linux" "$@"

"$SCRIPT_DIR/download/download_qttools.sh"

export CXXFLAGS="-DQT_MESSAGELOGCONTEXT"
export OBJCXXFLAGS="$CXXFLAGS"

mkdir qttools/_build && pushd qttools/_build
"$DEP_PREFIX/qt/bin/qt-configure-module" .. \
  -no-feature-assistant \
  -no-feature-designer \
  -no-feature-kmap2qmap \
  -no-feature-pixeltool \
  -no-feature-qdbus \
  -no-feature-qdoc \
  -no-feature-qev \
  -no-feature-qtattributionsscanner \
  -no-feature-qtdiag \
  -no-feature-qtplugininfo \
  -- \
  -Wno-dev
cmake --build .
cmake --install .
popd
