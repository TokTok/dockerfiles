#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

QRENCODE_VERSION=4.1.1
QRENCODE_HASH=5385bc1b8c2f20f3b91d258bf8ccc8cf62023935df2d2676b5b67049f31a049c

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/fukuchi/libqrencode/archive/refs/tags/v$QRENCODE_VERSION.tar.gz" \
  "$QRENCODE_HASH"
