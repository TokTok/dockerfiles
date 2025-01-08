#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

QTTOOLS_HASH=9d43d409be08b8681a0155a9c65114b69c9a3fc11aef6487bb7fdc5b283c432d

source "$(dirname "$(realpath "$0")")/common.sh"
source "$(dirname "$(realpath "$0")")/version_qt.sh"

MIRROR=http://master.qt-project.org

download_verify_extract_tarball \
  "$MIRROR/archive/qt/$QT_MAJOR.$QT_MINOR/$QT_MAJOR.$QT_MINOR.$QT_PATCH/submodules/qttools-everywhere-src-$QT_MAJOR.$QT_MINOR.$QT_PATCH.tar.xz" \
  "$QTTOOLS_HASH"
