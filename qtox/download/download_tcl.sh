#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team

set -euo pipefail

TCL_VERSION=8.6.18
TCL_HASH=14f9af32b1767ff718477a8f974ad03c34341097e6b43f4ce54644ee974e268e

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://downloads.sourceforge.net/project/tcl/Tcl/$TCL_VERSION/tcl$TCL_VERSION-src.tar.gz" \
  "$TCL_HASH"
