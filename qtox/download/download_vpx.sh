#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

VPX_VERSION=1.15.0
VPX_HASH=e935eded7d81631a538bfae703fd1e293aad1c7fd3407ba00440c95105d2011e

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/webmproject/libvpx/archive/v$VPX_VERSION.tar.gz" \
  "$VPX_HASH"
