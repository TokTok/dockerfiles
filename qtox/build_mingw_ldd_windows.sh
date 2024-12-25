#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euxo pipefail

"$(dirname "$(realpath "$0")")/download/download_mingw_ldd.sh"

cp -a mingw_ldd/mingw_ldd.py /usr/local/bin/mingw-ldd.py
