#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
#     Copyright (c) 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
#     Copyright (c) 2021 by The qTox Project Contributors

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "${SCRIPT_DIR}/build_utils.sh"

parse_arch --dep "mpfr" --supported "win32 win64" "$@"

"${SCRIPT_DIR}/download/download_mpfr.sh"

CC_FOR_BUILD=gcc CFLAGS="-O2 -g0 -I/windows/include" LDFLAGS="-L/windows/lib" \
  ./configure "${HOST_OPTION}" \
    --prefix="${DEP_PREFIX}" \
    --enable-static \
    --disable-shared
make -j "${MAKE_JOBS}"
make install
