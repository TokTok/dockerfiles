#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

NSISSHELLEXECASUSER_HASH=79bdd3e54a9ba9c30af85557b475d2322286f8726687f2e23afa772aac6049ab

source "$(dirname "$(realpath "$0")")/common.sh"

# Backup: https://web.archive.org/web/20220314233613/https://nsis.sourceforge.io/mediawiki/images/1/1d/ShellExecAsUserUnicodeUpdate.zip
download_file https://nsis.sourceforge.io/mediawiki/images/1/1d/ShellExecAsUserUnicodeUpdate.zip

if ! check_sha256 "$NSISSHELLEXECASUSER_HASH" ShellExecAsUserUnicodeUpdate.zip; then
  exit 1
fi

unzip ShellExecAsUserUnicodeUpdate.zip
rm ShellExecAsUserUnicodeUpdate.zip
