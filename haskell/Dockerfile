FROM ubuntu:20.04

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
 ca-certificates \
 curl \
 git \
 libtinfo-dev \
 && curl -sSL https://get.haskellstack.org/ | sh \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY stack.yaml /root/.stack/global-project/
# Install some tools.
RUN ["stack", "install", "hlint", "stylish-haskell"]
# Install commonly used libraries (every package needs tests).
RUN ["stack", "install", "QuickCheck", "hspec"]
# Install web frontend libraries (most packages have a web api).
RUN ["stack", "install", "servant", "servant-server"]
