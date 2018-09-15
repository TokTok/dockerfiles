#!/bin/bash

. set-env.sh
####################################################################################################

echo Deleting unused files from NDK installation in $NDK_PATH

rm -rf $NDK_PATH/build
rm -rf $NDK_PATH/platforms
rm -rf $NDK_PATH/prebuilt
rm -rf $NDK_PATH/sources/cxx-stl
rm -rf $NDK_PATH/toolchains

rm -rf ${BASH_SOURCE[0]}
