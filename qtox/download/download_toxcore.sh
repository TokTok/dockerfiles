#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

TOXCORE_VERSION=0.2.20
TOXCORE_HASH=a9c89a8daea745d53e5d78e7aacb99c7b4792c4400a5a69c71238f45d6164f4c

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  https://github.com/TokTok/c-toxcore/releases/download/v"$TOXCORE_VERSION/c-toxcore-$TOXCORE_VERSION".tar.gz \
  "$TOXCORE_HASH"
