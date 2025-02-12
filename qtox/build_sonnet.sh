#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "sonnet" --supported "linux-x86_64 macos-x86_64 macos-arm64 win32 win64 wasm" "$@"

"$SCRIPT_DIR/download/download_sonnet.sh"

sed_i() {
  if [ "$(uname)" = "Darwin" ]; then
    sed -i '' "$@"
  else
    sed -i "$@"
  fi
}

if [ "$LIB_TYPE" = "shared" ]; then
  CMAKE_CXX_FLAGS=
  ENABLE_SHARED=ON
  HUNSPELL_LIBRARIES=()
else
  CMAKE_CXX_FLAGS="-DSONNET_STATIC"
  ENABLE_SHARED=OFF
  HUNSPELL_LIBRARIES=("$(echo "$DEP_PREFIX"/lib/libhunspell*.a)")
  CMAKE_LISTS=()
  while IFS= read -r -d '' txt; do
    CMAKE_LISTS+=("$txt")
  done < <(find . -name CMakeLists.txt -print0)
  sed_i -e 's/ MODULE$/ STATIC/g' "${CMAKE_LISTS[@]}"
  sed_i -e 's/install(TARGETS sonnet_\([^ ]*\) /&EXPORT KF6SonnetTargets/g' "${CMAKE_LISTS[@]}"
  if [ "$SCRIPT_ARCH" = "macos-x86_64" ] || [ "$SCRIPT_ARCH" = "macos-arm64" ]; then
    sed_i -e 's/target_link_libraries(KF6SonnetCore PUBLIC Qt6::Core)/target_link_libraries(KF6SonnetCore PUBLIC Qt6::Core sonnet_hunspell sonnet_nsspellchecker)/' "${CMAKE_LISTS[@]}"
  else
    sed_i -e 's/target_link_libraries(KF6SonnetCore PUBLIC Qt6::Core)/target_link_libraries(KF6SonnetCore PUBLIC Qt6::Core sonnet_hunspell)/' "${CMAKE_LISTS[@]}"
  fi
fi

"$QT_PREFIX/bin/qt-cmake" \
  -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" \
  -DBUILD_SHARED_LIBS="$ENABLE_SHARED" \
  -DBUILD_DESIGNERPLUGIN=OFF \
  -DSONNET_USE_QML=OFF \
  "${HUNSPELL_LIBRARIES[@]}" \
  -DCMAKE_FIND_ROOT_PATH="$DEP_PREFIX" \
  -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS -DQT_MESSAGELOGCONTEXT" \
  -B_build \
  -GNinja \
  -Wno-dev \
  .
cmake --build _build
cmake --install _build
if [ -d "$DEP_PREFIX/include/KF6/SonnetUi/Sonnet" ]; then
  mv "$DEP_PREFIX/include/KF6/SonnetUi/Sonnet" "$DEP_PREFIX/include/KF6/SonnetUi/sonnet"
fi
