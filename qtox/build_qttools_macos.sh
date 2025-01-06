#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"
source "$SCRIPT_DIR/download/version_qt.sh"

parse_arch --dep "qttools" --supported "macos-arm64 macos-x86_64" "$@"

export CXXFLAGS="-DQT_MESSAGELOGCONTEXT"
export OBJCXXFLAGS="$CXXFLAGS"

tar Jxf <(curl -L "https://download.qt.io/archive/qt/$(echo "$QT_VERSION" | grep -o '...')/$QT_VERSION/submodules/qttools-everywhere-src-$QT_VERSION.tar.xz")
rm -rf qttools && mv "qttools-everywhere-src-$QT_VERSION" qttools && cd qttools
rm -rf _build && mkdir _build && cd _build
"$QT_PREFIX/bin/qt-configure-module" .. \
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
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -Wno-dev
cmake --build .
cmake --install .
cd ../..
rm -rf qttools
