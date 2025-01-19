#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

source "$(dirname "$(realpath "$0")")/common.sh"
source "$(dirname "$(realpath "$0")")/version_qt.sh"

MIRROR=http://master.qt-project.org

download_verify_extract_tarball \
  "$MIRROR/archive/qt/$QT_MAJOR.$QT_MINOR/$QT_MAJOR.$QT_MINOR.$QT_PATCH/submodules/qtwayland-everywhere-src-$QT_MAJOR.$QT_MINOR.$QT_PATCH.tar.xz" \
  "$QTWAYLAND_HASH"
