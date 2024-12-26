#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

GDB_VERSION="15.2"
GDB_HASH="83350ccd35b5b5a0cba6b334c41294ea968158c573940904f00b92f76345314d"

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "http://ftp.gnu.org/gnu/gdb/gdb-$GDB_VERSION.tar.xz" \
  "$GDB_HASH"
