#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

OPUS_VERSION=1.5.2
OPUS_HASH=65c1d2f78b9f2fb20082c38cbe47c951ad5839345876e46941612ee87f9a7ce1

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/xiph/opus/releases/download/v$OPUS_VERSION/opus-$OPUS_VERSION.tar.gz" \
  "$OPUS_HASH"
