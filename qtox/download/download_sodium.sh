#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

# https://github.com/jedisct1/libsodium/releases
SODIUM_VERSION=1.0.22
SODIUM_HASH=adbdd8f16149e81ac6078a03aca6fc03b592b89ef7b5ed83841c086191be3349

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/jedisct1/libsodium/releases/download/$SODIUM_VERSION-RELEASE/libsodium-$SODIUM_VERSION.tar.gz" \
  "$SODIUM_HASH"
