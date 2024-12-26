#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

SUDO=("$@")

build_toxcore() {
  mkdir -p toxcore
  pushd toxcore >/dev/null || exit 1

  "$SCRIPT_DIR/download/download_toxcore.sh"

  cmake . \
    -DBOOTSTRAP_DAEMON=OFF \
    -DMIN_LOGGER_LEVEL=DEBUG \
    -DCMAKE_BUILD_TYPE=Release \
    -GNinja \
    -B_build \
    .

  cmake --build _build -- -j"$(nproc)"
  "${SUDO[@]}" cmake --install _build

  popd >/dev/null
}

build_toxcore
