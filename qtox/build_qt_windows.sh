#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qt" --supported "win32 win64" "$@"

"$SCRIPT_DIR/download/download_qt.sh"

CROSS_COMPILE="$MINGW_ARCH-w64-mingw32-"
"${CROSS_COMPILE}gcc" --version

mkdir qtbase/_build && pushd qtbase/_build
../configure -prefix "$DEP_PREFIX" \
  -appstore-compliant \
  -release \
  -shared \
  -force-asserts \
  -qt-doubleconversion \
  -qt-freetype \
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
  -no-feature-sql \
  -no-feature-dbus \
  -no-opengl \
  -device-option "CROSS_COMPILE=$CROSS_COMPILE" \
  -qt-host-path /work/host/qt \
  -platform linux-g++ \
  -xplatform win32-g++ \
  -openssl-linked \
  -opensource -confirm-license \
  -pch \
  -- \
  -DCMAKE_TOOLCHAIN_FILE=/build/windows-toolchain.cmake \
  -DOPENSSL_ROOT_DIR=/windows \
  -DCMAKE_CXX_FLAGS="-DQT_MESSAGELOGCONTEXT" \
  -Wno-dev
cat config.summary
cmake --build .
cmake --install .
popd

mkdir qttools/_build && pushd qttools/_build
"$DEP_PREFIX/bin/qt-configure-module" .. \
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
  -DCMAKE_CXX_FLAGS="-DQT_MESSAGELOGCONTEXT" \
  -Wno-dev
cmake --build .
cmake --install .
popd

mkdir qtsvg/_build && pushd qtsvg/_build
"$DEP_PREFIX/bin/qt-configure-module" .. \
  -- \
  -DCMAKE_CXX_FLAGS="-DQT_MESSAGELOGCONTEXT" \
  -Wno-dev
cmake --build .
cmake --install .
popd

mkdir qtimageformats/_build && pushd qtimageformats/_build
"$DEP_PREFIX/bin/qt-configure-module" .. \
  -- \
  -DCMAKE_CXX_FLAGS="-DQT_MESSAGELOGCONTEXT" \
  -Wno-dev
cmake --build .
cmake --install .
popd
