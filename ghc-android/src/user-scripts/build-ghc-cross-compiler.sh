#!/bin/bash

. set-env-android.sh
####################################################################################################

./download-ghc.sh

cd $NDK_ADDON_SRC
tar xf ${GHC_TAR_PATH}
mv ghc-${GHC_RELEASE} "$GHC_SRC"
apply_patches 'ghc-*' "$GHC_SRC"
pushd "$GHC_SRC" > /dev/null

cp libraries/base/config.sub libraries/unix/config.sub

# Setup build.mk
cat > mk/build.mk <<EOF
Stage1Only           = YES
DYNAMIC_GHC_PROGRAMS = NO
SRC_HC_OPTS          = -O -H64m
GhcStage1HcOpts      = -O2 -fasm
GhcStage2HcOpts      = -O2 $ARCH_OPTS
GhcHcOpts            = -Rghc-timing
GhcLibHcOpts         = -O2 -fPIC
GhcLibWays           = v
STRIP_CMD            = $NDK/bin/$NDK_TARGET-strip
HADDOCK_DOCS         = NO
BUILD_DOCBOOK_HTML   = NO
BUILD_DOCBOOK_PS     = NO
BUILD_DOCBOOK_PDF    = NO
EOF

# Configure
perl boot
./configure \
  --enable-bootstrap-with-devel-snapshot \
  --prefix="$GHC_PREFIX" \
  --target="$NDK_TARGET" \
  GHC="$GHC_STAGE0" \
  CC="$NDK/bin/$NDK_TARGET-gcc" \
  CFLAGS="$CFLAGS -std=c99"

#
# The nature of parallel builds that once in a blue moon this directory does not get created
# before we try to "/usr/bin/install -c -m 644  utils/hsc2hs/template-hsc.h "/home/androidbuilder/.ghc/android-host/lib/ghc-8.0.1"
# This causes a conflict.
#
/usr/bin/install -c -m 755 -d "$GHC_PREFIX/lib/${NDK_ABI}-ghc-${GHC_RELEASE}/include/"
make $MAKEFLAGS
make install

popd

rm -rf ${BASH_SOURCE[0]} "$GHC_SRC"
rm -rf ${BASH_SOURCE[0]} "$GHC_TAR_PATH"
