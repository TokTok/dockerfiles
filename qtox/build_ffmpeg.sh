#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "ffmpeg" --supported "linux-x86_64 win32 win64 macos-x86_64 macos-arm64 wasm" "$@"

CONFIGURE_FLAGS=()
if [ "$LIB_TYPE" = "shared" ]; then
  CONFIGURE_FLAGS+=(--disable-static --enable-shared)
else
  CONFIGURE_FLAGS+=(--enable-static --disable-shared)
fi

if [ "$SCRIPT_ARCH" == "win64" ]; then
  FFMPEG_ARCH="x86_64"
  TARGET_OS="mingw32"
  CROSS_PREFIX="$MINGW_ARCH-w64-mingw32-"
elif [ "$SCRIPT_ARCH" == "win32" ]; then
  FFMPEG_ARCH="x86"
  TARGET_OS="mingw32"
  CROSS_PREFIX="$MINGW_ARCH-w64-mingw32-"
elif [ "$SCRIPT_ARCH" == "wasm" ]; then
  FFMPEG_ARCH="x86_32"
  TARGET_OS="none"
  CROSS_PREFIX=""
  CONFIGURE_FLAGS+=(
    --enable-cross-compile
    --disable-inline-asm
    --disable-x86asm
    --cc="emcc"
    --cxx="em++"
    --nm="$EMSDK/upstream/bin/llvm-nm -g"
    --ar="$EMSDK/upstream/bin/llvm-ar"
    --as="$EMSDK/upstream/bin/llvm-as"
    --ranlib="$EMSDK/upstream/bin/llvm-ranlib"
    --dep-cc="emcc"
  )
else
  FFMPEG_ARCH=""
  TARGET_OS=""
  CROSS_PREFIX=""
fi

"$SCRIPT_DIR/download/download_ffmpeg.sh"

CFLAGS="$CROSS_CFLAG" \
  CPPFLAGS="$CROSS_CPPFLAG" \
  LDFLAGS="$CROSS_LDFLAG" \
  "${EMCONFIGURE[@]}" ./configure --arch="$FFMPEG_ARCH" \
  --enable-gpl \
  "${CONFIGURE_FLAGS[@]}" \
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
