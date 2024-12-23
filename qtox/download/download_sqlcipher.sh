#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

SQLCIPHER_VERSION=4.6.1
SQLCIPHER_HASH=d8f9afcbc2f4b55e316ca4ada4425daf3d0b4aab25f45e11a802ae422b9f53a3

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/sqlcipher/sqlcipher/archive/v$SQLCIPHER_VERSION.tar.gz" \
  "$SQLCIPHER_HASH"
