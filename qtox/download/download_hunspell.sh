#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

# https://github.com/hunspell/hunspell/releases
HUNSPELL_VERSION=1.7.6
HUNSPELL_HASH=9c650ace31d4d8cc1da925a9507c3de1d50f1a54857af2f72429f517d5d53467

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/hunspell/hunspell/releases/download/v$HUNSPELL_VERSION/hunspell-$HUNSPELL_VERSION.tar.gz" \
  "$HUNSPELL_HASH"
