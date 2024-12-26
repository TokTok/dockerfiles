#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

EXPAT_VERSION="2.6.4"
EXPAT_HASH="a695629dae047055b37d50a0ff4776d1d45d0a4c842cf4ccee158441f55ff7ee"

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/libexpat/libexpat/releases/download/R_${EXPAT_VERSION//./_}/expat-$EXPAT_VERSION.tar.xz" \
  "$EXPAT_HASH"
