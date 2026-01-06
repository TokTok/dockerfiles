#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

MPFR_VERSION=4.2.1
MPFR_HASH=ed8a128e1446e7cca92add1681a6431ba8c1a3250048c6c72648c1bafbe3e8d3

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://www.mpfr.org/mpfr-current/mpfr-$MPFR_VERSION.tar.gz" \
  "$MPFR_HASH"
