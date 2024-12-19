#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024 The TokTok team

set -euo pipefail

SONNET_VERSION=6.9.0
SONNET_HASH=7fabe11d489b3baa4d181df0168e659766a728f812cd76fe363be21393cab86a

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/KDE/sonnet/archive/refs/tags/v$SONNET_VERSION.tar.gz" \
  "$SONNET_HASH"
