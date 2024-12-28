#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

SODIUM_VERSION=1.0.20-RELEASE
SODIUM_HASH=ebb65ef6ca439333c2bb41a0c1990587288da07f6c7fd07cb3a18cc18d30ce19

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/jedisct1/libsodium/releases/download/$SODIUM_VERSION/libsodium-${SODIUM_VERSION/-RELEASE/}.tar.gz" \
  "$SODIUM_HASH"
