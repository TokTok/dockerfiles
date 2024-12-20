#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "ffmpeg" --supported "win32 win64 macos macos-x86_64 macos-arm64" "$@"

if [ "$SCRIPT_ARCH" == "win64" ]; then
  FFMPEG_ARCH="x86_64"
  TARGET_OS="mingw32"
  CROSS_PREFIX="$MINGW_ARCH-w64-mingw32-"
elif [ "$SCRIPT_ARCH" == "win32" ]; then
  FFMPEG_ARCH="x86"
  TARGET_OS="mingw32"
  CROSS_PREFIX="$MINGW_ARCH-w64-mingw32-"
else
  FFMPEG_ARCH=""
  TARGET_OS=""
  CROSS_PREFIX=""
fi

if [ "$LIB_TYPE" = "shared" ]; then
  ENABLE_STATIC=--disable-static
  ENABLE_SHARED=--enable-shared
else
  ENABLE_STATIC=--enable-static
  ENABLE_SHARED=--disable-shared
fi

"$SCRIPT_DIR/download/download_ffmpeg.sh"

CFLAGS="$CROSS_CFLAG" \
  CPPFLAGS="$CROSS_CPPFLAG" \
  LDFLAGS="$CROSS_LDFLAG" \
  ./configure --arch="$FFMPEG_ARCH" \
  --enable-gpl \
  "$ENABLE_STATIC" \
  "$ENABLE_SHARED" \
  --prefix="$DEP_PREFIX" \
  --target-os="$TARGET_OS" \
  --cross-prefix="$CROSS_PREFIX" \
  --pkg-config="pkg-config" \
  --extra-cflags="-O2 -g0" \
  --disable-libxcb \
  --disable-debug \
  --disable-programs \
  --disable-protocols \
  --disable-doc \
  --disable-sdl2 \
  --disable-avfilter \
  --disable-filters \
  --disable-iconv \
  --disable-network \
  --disable-muxers \
  --disable-postproc \
  --disable-swresample \
  --disable-swscale-alpha \
  --disable-dwt \
  --disable-lsp \
  --disable-faan \
  --disable-vaapi \
  --disable-vdpau \
  --disable-zlib \
  --disable-xlib \
  --disable-bzlib \
  --disable-lzma \
  --disable-encoders \
  --disable-decoders \
  --disable-demuxers \
  --disable-parsers \
  --disable-bsfs \
  --enable-demuxer=h264 \
  --enable-demuxer=mjpeg \
  --enable-parser=h264 \
  --enable-parser=mjpeg \
  --enable-decoder=h264 \
  --enable-decoder=mjpeg \
  --enable-decoder=rawvideo

make -j "$MAKE_JOBS"
make install
