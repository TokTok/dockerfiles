#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

QT_MAJOR=6
QT_MINOR=8
QT_PATCH=1
QTTOOLS_HASH=9d43d409be08b8681a0155a9c65114b69c9a3fc11aef6487bb7fdc5b283c432d

source "$(dirname "$(realpath "$0")")/common.sh"

MIRROR=http://master.qt-project.org

(
  mkdir qttools && cd qttools
  download_verify_extract_tarball \
    "$MIRROR/archive/qt/$QT_MAJOR.$QT_MINOR/$QT_MAJOR.$QT_MINOR.$QT_PATCH/submodules/qttools-everywhere-src-$QT_MAJOR.$QT_MINOR.$QT_PATCH.tar.xz" \
    "$QTTOOLS_HASH"
)
