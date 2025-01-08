#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

QTREMOTEOBJECTS_HASH=7ef2870f05614b71d1cfdd7ac12acef5294abc43da244a6e9e411f21208f59f8

source "$(dirname "$(realpath "$0")")/common.sh"
source "$(dirname "$(realpath "$0")")/version_qt.sh"

MIRROR=http://master.qt-project.org

download_verify_extract_tarball \
  "$MIRROR/archive/qt/$QT_MAJOR.$QT_MINOR/$QT_MAJOR.$QT_MINOR.$QT_PATCH/submodules/qtremoteobjects-everywhere-src-$QT_MAJOR.$QT_MINOR.$QT_PATCH.tar.xz" \
  "$QTREMOTEOBJECTS_HASH"
