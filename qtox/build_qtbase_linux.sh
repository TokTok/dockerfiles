#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qtbase" --supported "linux-x86_64" "$@"

"$SCRIPT_DIR/download/download_qtbase.sh"

export CXXFLAGS="-DQT_MESSAGELOGCONTEXT"
export OBJCXXFLAGS="$CXXFLAGS"

mkdir -p qtbase/_build
pushd qtbase/_build
../configure -prefix "$DEP_PREFIX/qt" \
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
  -feature-wayland \
  -feature-zstd \
  -no-feature-androiddeployqt \
  -no-feature-brotli \
  -no-feature-macdeployqt \
  -no-feature-printsupport \
  -no-feature-qmake \
  -no-feature-sql \
  -no-glib \
  -no-opengl \
  -fontconfig \
  -dbus-linked \
  -openssl-linked \
  -opensource -confirm-license \
  -pch \
  -xcb \
  -- \
  -DTEST_xcb_syslibs=TRUE \
  -Wno-dev
cat config.summary
cmake --build .
cmake --install .
popd
