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

if [ -n "$SANITIZE" ]; then
  QT_CONFIGURE_FLAGS=(-sanitize "$CLANG_SANITIZER")
  BUILD_TYPE=debug
else
  QT_CONFIGURE_FLAGS=()
fi

if [ "$BUILD_TYPE" = "debug" ]; then
  QT_CONFIGURE_FLAGS+=("-force-debug-info")
else
  QT_CONFIGURE_FLAGS+=("-no-force-debug-info")
fi

mkdir -p _build
pushd _build
../configure \
  -prefix "$QT_PREFIX" \
  -appstore-compliant \
  -release \
  -force-asserts \
  "${QT_CONFIGURE_FLAGS[@]}" \
  "-$LIB_TYPE" \
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
