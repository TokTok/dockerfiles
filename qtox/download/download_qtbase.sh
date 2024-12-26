#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

QT_MAJOR=6
QT_MINOR=8
QT_PATCH=1
QTBASE_HASH=40b14562ef3bd779bc0e0418ea2ae08fa28235f8ea6e8c0cb3bce1d6ad58dcaf

source "$(dirname "$(realpath "$0")")/common.sh"

MIRROR=http://master.qt-project.org

(
  mkdir qtbase && cd qtbase
  download_verify_extract_tarball \
    "$MIRROR/archive/qt/$QT_MAJOR.$QT_MINOR/$QT_MAJOR.$QT_MINOR.$QT_PATCH/submodules/qtbase-everywhere-src-$QT_MAJOR.$QT_MINOR.$QT_PATCH.tar.xz" \
    "$QTBASE_HASH"
)
