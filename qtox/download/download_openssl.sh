#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

OPENSSL_VERSION=4.1.0
OPENSSL_HASH=50c17baf54cb008f6ce42d50deb4b28050a1aad711636cabd4b241c7e90cc2fd

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz" \
  "$OPENSSL_HASH"
