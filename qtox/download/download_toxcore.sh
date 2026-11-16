#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2026 The TokTok team

set -euo pipefail

TOXCORE_VERSION=0.2.25
TOXCORE_HASH=754b593aa922b8f28f81525af8dfd7c76df1344307919a1ff2543c0283611850

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  https://github.com/TokTok/c-toxcore/releases/download/v"$TOXCORE_VERSION/c-toxcore-v$TOXCORE_VERSION".tar.gz \
  "$TOXCORE_HASH"
