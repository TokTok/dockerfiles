#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024 The TokTok team

set -euo pipefail

HUNSPELL_VERSION=1.7.2
HUNSPELL_HASH=11ddfa39afe28c28539fe65fc4f1592d410c1e9b6dd7d8a91ca25d85e9ec65b8

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/hunspell/hunspell/releases/download/v$HUNSPELL_VERSION/hunspell-$HUNSPELL_VERSION.tar.gz" \
  "$HUNSPELL_HASH"
