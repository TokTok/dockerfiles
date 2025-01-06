#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

GMP_VERSION=6.3.0
GMP_HASH=a3c2b80201b89e68616f4ad30bc66aee4927c3ce50e33929ca819d5c43538898

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "http://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.xz" \
  "$GMP_HASH"
