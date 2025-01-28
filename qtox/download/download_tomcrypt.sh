#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team

set -euo pipefail

TOMCRYPT_VERSION=1.18.2
TOMCRYPT_HASH=96ad4c3b8336050993c5bc2cf6c057484f2b0f9f763448151567fbab5e767b84

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/libtom/libtomcrypt/releases/download/v$TOMCRYPT_VERSION/crypt-$TOMCRYPT_VERSION.tar.xz" \
  "$TOMCRYPT_HASH"
