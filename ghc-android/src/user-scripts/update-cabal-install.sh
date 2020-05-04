#!/bin/bash

. set-env-android.sh
####################################################################################################

"$NDK_TARGET"-cabal update
CFG=$NDK/.cabal/config

sed 's/^\(jobs.*\)$/-- \1/' "$CFG" >"$CFG".new
rm -f "$CFG"
mv "$CFG".new "$CFG"

rm -rf "${BASH_SOURCE[0]}"
