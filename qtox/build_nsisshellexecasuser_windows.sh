#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

"$(dirname "$(realpath "$0")")/download/download_nsisshellexecasuser.sh"

cp unicode/ShellExecAsUser.dll /usr/share/nsis/Plugins/x86-unicode
