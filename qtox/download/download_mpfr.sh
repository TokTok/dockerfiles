#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

MPFR_VERSION=4.2.2
MPFR_HASH=826cbb24610bd193f36fde172233fb8c009f3f5c2ad99f644d0dea2e16a20e42

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://www.mpfr.org/mpfr-current/mpfr-$MPFR_VERSION.tar.gz" \
  "$MPFR_HASH"
