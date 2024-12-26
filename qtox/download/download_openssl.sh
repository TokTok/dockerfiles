#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

OPENSSL_VERSION=3.4.0
OPENSSL_HASH=e15dda82fe2fe8139dc2ac21a36d4ca01d5313c75f99f46c4e8a27709b7294bf

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz" \
  "$OPENSSL_HASH"
