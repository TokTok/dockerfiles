#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

cd $NDK_ADDON_SRC
tar xf ${GHC_TAR_PATH}
mv ghc-${GHC_RELEASE} "$GHC_SRC"
apply_patches 'ghc-*' "$GHC_SRC"
pushd "$GHC_SRC" > /dev/null

# Setup build.mk
cat > mk/build.mk <<EOF
Stage1Only = YES
DYNAMIC_GHC_PROGRAMS = NO
SRC_HC_OPTS     = -O -H64m
GhcStage1HcOpts = -O2 -fasm
GhcStage2HcOpts = -O2 -fasm $ARCH_OPTS
GhcHcOpts       = -Rghc-timing
GhcLibHcOpts    = -O2
GhcLibWays      = v
HADDOCK_DOCS       = NO
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO
EOF

# Update config.sub and config.guess
for x in $(find . -name "config.sub") ; do
  dir=$(dirname $x)
  cp -v "$CONFIG_SUB_SRC/config.sub" "$dir"
  cp -v "$CONFIG_SUB_SRC/config.guess" "$dir"
done

# Configure
perl boot
./configure --enable-bootstrap-with-devel-snapshot --prefix="$GHC_PREFIX" --target=$NDK_TARGET \
  --with-ghc=$GHC_STAGE0 --with-gcc=$NDK/bin/$NDK_TARGET-gcc

#
# The nature of parallel builds that once in a blue moon this directory does not get created
# before we try to "/usr/bin/install -c -m 644  utils/hsc2hs/template-hsc.h "/home/androidbuilder/.ghc/android-host/lib/ghc-8.0.1"
# This causes a conflict.
#
/usr/bin/install -c -m 755 -d "$GHC_PREFIX/lib/${NDK_ABI}-ghc-${GHC_RELEASE}/include/"
make $MAKEFLAGS
make install

rm -rf ${BASH_SOURCE[0]} "$GHC_SRC"
