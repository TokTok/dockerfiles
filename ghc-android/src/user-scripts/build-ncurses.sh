#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo Downloading ncurses $NCURSES_RELEASE
curl -o "${TARDIR}/${NCURSES_TAR_FILE}"  http://ftp.gnu.org/pub/gnu/ncurses/${NCURSES_TAR_FILE} 2>&1
check_md5 "$NCURSES_TAR_PATH" "$NCURSES_MD5"

pushd $NDK_ADDON_SRC
tar xf "$TARDIR/$NCURSES_TAR_FILE"
popd

pushd $NCURSES_SRC
./configure --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH --with-build-cc=$BUILD_GCC --enable-static --disable-shared --includedir="$NDK_ADDON_PREFIX/include" --without-manpages
echo '#undef HAVE_LOCALE_H' >> "$NCURSES_SRC/include/ncurses_cfg.h"   # TMP hack
make $MAKEFLAGS
make install
popd

rm -rf ${BASH_SOURCE[0]} $NCURSES_SRC "$TARDIR/$NCURSES_TAR_FILE"
