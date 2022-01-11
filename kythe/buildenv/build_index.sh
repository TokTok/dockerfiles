#!/bin/bash

set -eux

# Android SDK is needed even when we don't build Android stuff because WORKSPACE
# configuration fails otherwise.
ln -s /third_party/android/sdk third_party/android/sdk

# We list the packages to build here instead of in the "tables" image, because
# we should never build a different set of paths in that image when building
# from different repositories. E.g. both dockerfiles and toktok-stack want to
# push this image.
#
# Also note we disable layering_check because it's incompatible with Kythe.
bazel --bazelrc=/opt/kythe/extractors.bazelrc build \
  --build_tag_filters=-haskell \
  --test_tag_filters=-haskell \
  --config=docker \
  --features=-layering_check \
  --override_repository kythe_release=/opt/kythe \
  //c-toxcore/... \
  //toxic/...

# Find the extracted .kzip files
find -L bazel-out -name '*.cxx.kzip' |
  parallel -t -L4 /opt/kythe/indexers/cxx_indexer |
  /opt/kythe/tools/dedup_stream >cxx.entries

mkdir /data
/opt/kythe/tools/write_tables --entries cxx.entries --out /data/kythe_tables
