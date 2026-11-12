#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

GDB_VERSION="18.1"
GDB_HASH="cd9fc3fe2b47743840e42c1592d3d87f8302eb18639c0b8b4ba0898002e2348f"

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "http://ftp.gnu.org/gnu/gdb/gdb-$GDB_VERSION.tar.xz" \
  "$GDB_HASH"
