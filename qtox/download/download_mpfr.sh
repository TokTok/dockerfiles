#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

MPFR_VERSION=4.2.1
MPFR_HASH=116715552bd966c85b417c424db1bbdf639f53836eb361549d1f8d6ded5cb4c6

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://www.mpfr.org/mpfr-current/mpfr-$MPFR_VERSION.tar.gz" \
  "$MPFR_HASH"
