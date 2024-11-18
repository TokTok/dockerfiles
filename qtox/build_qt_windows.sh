#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
#     Copyright (c) 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
#     Copyright (c) 2021 by The qTox Project Contributors

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "${SCRIPT_DIR}/build_utils.sh"

parse_arch --dep "qt" --supported "win32 win64" "$@"

"${SCRIPT_DIR}/download/download_qt.sh"

OPENSSL_LIBS=$(pkg-config --libs openssl)
export OPENSSL_LIBS

CROSS_COMPILE="${MINGW_ARCH}-w64-mingw32-"
"${CROSS_COMPILE}gcc" --version

./configure -prefix "${DEP_PREFIX}" \
    -release \
    -shared \
    -device-option "CROSS_COMPILE=${CROSS_COMPILE}" \
    -qt-host-path /usr/lib/x86_64-linux-gnu/cmake \
    -platform linux-g++ \
    -xplatform win32-g++ \
    -openssl "$(pkg-config --cflags --libs openssl)" \
    -openssl-linked \
    -opensource -confirm-license \
    -pch \
    -nomake examples \
    -nomake tests \
    -submodules qtbase,qtsvg,qttools \
    -skip qtactiveqt \
    -skip qtdeclarative \
    -skip qtlanguageserver \
    -skip qtshadertools \
    -no-feature-assistant \
    -no-feature-designer \
    -no-dbus \
    -no-icu \
    -qt-libjpeg \
    -qt-libpng \
    -qt-zlib \
    -qt-pcre \
    -opengl desktop \
    -- \
    -DCMAKE_TOOLCHAIN_FILE=/build/windows-toolchain.cmake \
    -DOPENSSL_ROOT_DIR=/windows

cmake --build .
cmake --install .
