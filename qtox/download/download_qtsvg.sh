#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

QTSVG_HASH=3d0de73596e36b2daa7c48d77c4426bb091752856912fba720215f756c560dd0

source "$(dirname "$(realpath "$0")")/common.sh"
source "$(dirname "$(realpath "$0")")/version_qt.sh"

MIRROR=http://master.qt-project.org

(
  mkdir qtsvg && cd qtsvg
  download_verify_extract_tarball \
    "$MIRROR/archive/qt/$QT_MAJOR.$QT_MINOR/$QT_MAJOR.$QT_MINOR.$QT_PATCH/submodules/qtsvg-everywhere-src-$QT_MAJOR.$QT_MINOR.$QT_PATCH.tar.xz" \
    "$QTSVG_HASH"
)
