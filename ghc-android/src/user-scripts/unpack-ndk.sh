#!/bin/bash

. set-env-android.sh
####################################################################################################

echo Unpacking the Android NDK $NDK_RELEASE
./unpack-ndk.pl $NDK_RELEASE $NDK_TAR_PATH $NDK_TARGET
rm "$NDK_TAR_PATH"

rm -f ${BASH_SOURCE[0]}
