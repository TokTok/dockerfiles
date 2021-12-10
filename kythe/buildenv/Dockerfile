# The build environment for toktok-stack builds.
# We're building this separately so the rebuild is minimal.
FROM toxchat/kythe-release:latest AS release
FROM ubuntu:20.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 build-essential \
 clang \
 default-jdk \
 git \
 libasound-dev \
 libncurses-dev \
 libssl-dev \
 libx11-dev \
 parallel \
 python3 \
 python3.8-dev \
 unzip \
 wget \
 zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV CC=clang CXX=clang++

RUN wget -q https://github.com/bazelbuild/bazel/releases/download/4.2.2/bazel_4.2.2-linux-x86_64.deb \
 && dpkg -i bazel_4.2.2-linux-x86_64.deb \
 && rm bazel_4.2.2-linux-x86_64.deb

COPY --from=release /opt/kythe /opt/kythe
COPY build_index.sh /opt/

WORKDIR /src/workspace
