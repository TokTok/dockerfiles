#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

VPX_VERSION=1.17.0
VPX_HASH=1020f184046187baa2985dbde38e0691f49c44088bca7a1842b0236c6081dc0a

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/webmproject/libvpx/archive/v$VPX_VERSION.tar.gz" \
  "$VPX_HASH"
