#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

QTIMAGEFORMATS_HASH=138cc2909aa98f5ff7283e36eb3936eb5e625d3ca3b4febae2ca21d8903dd237

source "$(dirname "$(realpath "$0")")/common.sh"
source "$(dirname "$(realpath "$0")")/version_qt.sh"

MIRROR=http://master.qt-project.org

(
  mkdir qtimageformats && cd qtimageformats
  download_verify_extract_tarball \
    "$MIRROR/archive/qt/$QT_MAJOR.$QT_MINOR/$QT_MAJOR.$QT_MINOR.$QT_PATCH/submodules/qtimageformats-everywhere-src-$QT_MAJOR.$QT_MINOR.$QT_PATCH.tar.xz" \
    "$QTIMAGEFORMATS_HASH"
)
