#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2026 The TokTok team

set -euo pipefail

TOXCORE_VERSION=0.2.24-rc.3
TOXCORE_HASH=797500ee66278318175d5248afe00144f0840ea029186d1f7ac733bda3aa78d3

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  https://github.com/TokTok/c-toxcore/releases/download/v"$TOXCORE_VERSION/c-toxcore-v$TOXCORE_VERSION".tar.gz \
  "$TOXCORE_HASH"
