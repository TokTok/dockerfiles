#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

QT_MAJOR=6
QT_MINOR=8
QT_PATCH=1
QTWAYLAND_HASH=2226fbde4e2ddd12f8bf4b239c8f38fd706a54e789e63467dfddc77129eca203

source "$(dirname "$(realpath "$0")")/common.sh"

MIRROR=http://master.qt-project.org

(
  mkdir qtwayland && cd qtwayland
  download_verify_extract_tarball \
    "$MIRROR/archive/qt/$QT_MAJOR.$QT_MINOR/$QT_MAJOR.$QT_MINOR.$QT_PATCH/submodules/qtwayland-everywhere-src-$QT_MAJOR.$QT_MINOR.$QT_PATCH.tar.xz" \
    "$QTWAYLAND_HASH"
)
