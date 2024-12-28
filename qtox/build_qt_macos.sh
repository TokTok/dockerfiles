#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"
source "$SCRIPT_DIR/download/version_qt.sh"

parse_arch --dep "qt" --supported "macos-arm64 macos-x86_64" "$@"

export CXXFLAGS="-DQT_MESSAGELOGCONTEXT"
export OBJCXXFLAGS="$CXXFLAGS"

if [ -n "$SANITIZE" ]; then
  QT_SANITIZE=(-sanitize "$CLANG_SANITIZER")
  BUILD_TYPE=debug
else
  QT_SANITIZE=()
fi

if [ "$BUILD_TYPE" = "debug" ]; then
  QT_FORCE_DEBUG_INFO="-force-debug-info"
else
  QT_FORCE_DEBUG_INFO="-no-force-debug-info"
fi

tar Jxf <(curl -L "https://download.qt.io/archive/qt/$(echo "$QT_VERSION" | grep -o '...')/$QT_VERSION/submodules/qtbase-everywhere-src-$QT_VERSION.tar.xz")
rm -rf qtbase && mv "qtbase-everywhere-src-$QT_VERSION" qtbase && cd qtbase
rm -rf _build && mkdir _build && cd _build
../configure \
  --prefix="$QT_PREFIX" \
  -appstore-compliant \
  -static \
  -release \
  -force-asserts \
  "$QT_FORCE_DEBUG_INFO" \
  "${QT_SANITIZE[@]}" \
  -qt-doubleconversion \
  -qt-freetype \
  -qt-harfbuzz \
  -qt-libjpeg \
  -qt-libpng \
  -qt-pcre \
  -qt-zlib \
  -no-feature-androiddeployqt \
  -no-feature-brotli \
  -no-feature-macdeployqt \
  -no-feature-printsupport \
  -no-feature-qmake \
  -no-feature-sql \
  -no-feature-dbus \
  -no-opengl \
  -no-openssl \
  -- \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -Wno-dev
cat config.summary
cmake --build .
cmake --install .
cd ../..
rm -rf qtbase

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

tar Jxf <(curl -L "https://download.qt.io/archive/qt/$(echo "$QT_VERSION" | grep -o '...')/$QT_VERSION/submodules/qtsvg-everywhere-src-$QT_VERSION.tar.xz")
rm -rf qtsvg && mv "qtsvg-everywhere-src-$QT_VERSION" qtsvg && cd qtsvg
rm -rf _build && mkdir _build && cd _build
"$QT_PREFIX/bin/qt-configure-module" .. \
  -- \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -Wno-dev
cmake --build .
cmake --install .
cd ../..
rm -rf qtsvg

tar Jxf <(curl -L "https://download.qt.io/archive/qt/$(echo "$QT_VERSION" | grep -o '...')/$QT_VERSION/submodules/qtimageformats-everywhere-src-$QT_VERSION.tar.xz")
rm -rf qtimageformats && mv "qtimageformats-everywhere-src-$QT_VERSION" qtimageformats && cd qtimageformats
rm -rf _build && mkdir _build && cd _build
"$QT_PREFIX/bin/qt-configure-module" .. \
  -- \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -Wno-dev
cmake --build .
cmake --install .
cd ../..
rm -rf qtimageformats
