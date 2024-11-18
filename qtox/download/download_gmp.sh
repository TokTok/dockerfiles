#!/bin/bash

#    Copyright © 2021 by The qTox Project Contributors
#
#    This program is libre software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -euo pipefail

GMP_VERSION=6.3.0
GMP_HASH=a3c2b80201b89e68616f4ad30bc66aee4927c3ce50e33929ca819d5c43538898

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "http://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.xz" \
  "$GMP_HASH"
