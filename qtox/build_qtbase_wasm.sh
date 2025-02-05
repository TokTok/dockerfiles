#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qtbase" --supported "wasm" "$@"

"$SCRIPT_DIR/download/download_qtbase.sh"

export CXXFLAGS="-DQT_MESSAGELOGCONTEXT"
export OBJCXXFLAGS="$CXXFLAGS"

mkdir -p _build
pushd _build
../configure \
  -prefix "$QT_PREFIX" \
  -appstore-compliant \
  -release \
  "-$LIB_TYPE" \
  -force-asserts \
  -qt-doubleconversion \
  -qt-harfbuzz \
  -qt-libjpeg \
  -qt-libpng \
  -qt-pcre \
  -qt-zlib \
  -feature-zstd \
  -no-feature-androiddeployqt \
  -no-feature-brotli \
  -no-feature-macdeployqt \
  -no-feature-printsupport \
  -no-feature-qmake \
  -no-feature-sharedmemory \
  -no-feature-sql \
  -no-dbus \
  -no-glib \
  -no-openssl \
  -device-option "QT_EMSCRIPTEN_ASYNCIFY=1" \
  -qt-host-path /opt/buildhome/host/qt \
  -platform wasm-emscripten \
  -feature-thread \
  -feature-wasm-simd128 \
  -opensource -confirm-license \
  -pch \
  -- \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -Wno-dev
cat config.summary
cmake --build .
cmake --install .
popd
