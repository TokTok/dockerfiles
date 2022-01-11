# The build environment for toktok-stack builds.
# We're building this separately so the rebuild is minimal.
FROM toxchat/kythe-release:latest AS release
FROM toxchat/bazel:latest

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 libasound-dev \
 libncurses5-dev \
 libncursesw5-dev \
 libssl-dev \
 libx11-dev \
 parallel \
 unzip \
 zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# hadolint ignore=SC3001
RUN bash <(curl https://raw.githubusercontent.com/TokTok/toktok-stack/master/tools/prepare_android_sdk.sh)

ENV CC=clang CXX=clang++

COPY --from=release /opt/kythe /opt/kythe
COPY build_index.sh /opt/

WORKDIR /src/workspace
