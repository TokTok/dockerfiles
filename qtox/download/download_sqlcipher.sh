#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

SQLCIPHER_VERSION=4.20.0
SQLCIPHER_HASH=38705f51b61ac0636a5fd064f9a77fafabc7227b2aa2513f1b14c8bb1102affc

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/sqlcipher/sqlcipher/archive/v$SQLCIPHER_VERSION.tar.gz" \
  "$SQLCIPHER_HASH"
