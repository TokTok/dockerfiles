#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team

set -euo pipefail

TCL_VERSION=8.6.10
TCL_HASH=5196dbf6638e3df8d5c87b5815c8c2b758496eb6f0e41446596c9a4e638d87ed

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://downloads.sourceforge.net/project/tcl/Tcl/$TCL_VERSION/tcl$TCL_VERSION-src.tar.gz" \
  "$TCL_HASH"
