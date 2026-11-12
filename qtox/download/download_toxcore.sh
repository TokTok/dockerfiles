#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2026 The TokTok team

set -euo pipefail

TOXCORE_VERSION=0.2.24
TOXCORE_HASH=c07658e6f4d195b659941aa8dcc20a8499435e6cdfd036bbb3f2ab2cbf03bd7c

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  https://github.com/TokTok/c-toxcore/releases/download/v"$TOXCORE_VERSION/c-toxcore-v$TOXCORE_VERSION".tar.gz \
  "$TOXCORE_HASH"
