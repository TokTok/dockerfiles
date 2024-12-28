#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "gmp" --supported "win32 win64" "$@"

"$SCRIPT_DIR/download/download_gmp.sh"

# https://gmplib.org/list-archives/gmp-discuss/2020-July/006519.html
CC_FOR_BUILD=gcc CFLAGS="-O2 -g0" ./configure "$HOST_OPTION" \
  --prefix="$DEP_PREFIX" \
  --enable-static \
  --disable-shared
make -j "$MAKE_JOBS"
make install
