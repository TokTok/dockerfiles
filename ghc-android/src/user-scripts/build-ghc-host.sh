#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

cd $NDK_ADDON_SRC
tar xf ${GHC_TAR_PATH}
mv ghc-${GHC_RELEASE} "$GHC_STAGE0_SRC"
pushd "$GHC_STAGE0_SRC" > /dev/null

# Setup build.mk
cat > mk/build.mk <<EOF
HADDOCK_DOCS       = NO
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO
EOF

# Configure
perl boot
./configure --prefix="$GHC_STAGE0_PREFIX"

#
# The nature of parallel builds that once in a blue moon this directory does not get created
# before we try to "/usr/bin/install -c -m 644  utils/hsc2hs/template-hsc.h "/home/androidbuilder/.ghc/android-host/lib/ghc-8.0.1"
# This causes a conflict.
#
/usr/bin/install -c -m 755 -d "$GHC_STAGE0_PREFIX/lib/ghc-$GHC_RELEASE/include"
make $MAKEFLAGS
make $MAKEFLAGS install

rm -rf ${BASH_SOURCE[0]} "$GHC_STAGE0_SRC"
