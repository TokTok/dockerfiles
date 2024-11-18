#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
#     Copyright (c) 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
#     Copyright (c) 2021 by The qTox Project Contributors

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "${SCRIPT_DIR}/build_utils.sh"

parse_arch --dep "glfw" --supported "win32 win64" "$@"

"${SCRIPT_DIR}/download/download_glfw.sh"

cmake -DCMAKE_INSTALL_PREFIX=/windows/ \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_TOOLCHAIN_FILE=/build/windows-toolchain.cmake \
      -GNinja \
      .

cmake --build . --target install
