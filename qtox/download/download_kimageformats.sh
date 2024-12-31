#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024 The TokTok team

set -euo pipefail

# https://github.com/KDE/kimageformats/tags
KIMAGEFORMATS_VERSION=6.9.0
KIMAGEFORMATS_HASH=5db2860ddcdf430a875815509d914a3243a82d2c06aa06436ef6725d309da8f7

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/KDE/kimageformats/archive/refs/tags/v$KIMAGEFORMATS_VERSION.tar.gz" \
  "$KIMAGEFORMATS_HASH"
