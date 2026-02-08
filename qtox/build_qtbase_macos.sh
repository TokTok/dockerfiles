#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qtbase" --supported "macos-arm64 macos-x86_64 ios-arm64 iphonesimulator-arm64 iphonesimulator-x86_64" "$@"

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

if [[ "$SCRIPT_ARCH" == "ios-"* ]]; then
  QT_CONFIGURE_FLAGS+=("-sdk" "iphoneos" "-no-feature-printsupport" "-no-feature-icu" "-no-feature-filesystemwatcher")
elif [[ "$SCRIPT_ARCH" == "iphonesimulator-"* ]]; then
  QT_CONFIGURE_FLAGS+=("-sdk" "iphonesimulator" "-no-feature-printsupport" "-no-feature-icu" "-no-feature-filesystemwatcher")
else
  if [ "$MACOS_MINIMUM_SUPPORTED_VERSION" != "10.15" ]; then
    QT_CONFIGURE_FLAGS+=("-no-feature-printsupport")
  fi
fi

if [ -n "$QT_HOST_PATH" ]; then
  QT_CONFIGURE_FLAGS+=("-qt-host-path" "$QT_HOST_PATH")
fi

# We want -Werror to catch warnings related to macOS version compatibility.
# We silence unused-variable because disabling features (like filesystemwatcher) can leave variables unused in Qt's source.
sed -i '' -e 's/-Wextra/-Wextra -Werror "-Wno-#warnings" -Wno-cast-function-type-mismatch -Wno-deprecated-declarations -Wno-unused-but-set-variable -Wno-unused-variable -Wno-vla-cxx-extension/' cmake/QtCompilerFlags.cmake

mkdir _build && pushd _build
../configure \
  -platform macx-clang \
  --prefix="$QT_PREFIX" \
  -appstore-compliant \
  -static \
  -release \
  -force-asserts \
  "${QT_CONFIGURE_FLAGS[@]}" \
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
  -no-feature-qmake \
  -no-feature-sql \
  -no-feature-dbus \
  -no-opengl \
  -no-openssl \
  -- \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  "${CMAKE_TOOLCHAIN_FILE[@]}" \
  -Wno-dev
cat config.summary
cmake --build .
cmake --install .
popd
