FROM ubuntu:20.04

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
 ca-certificates \
 curl \
 git \
 && curl -sSL https://get.haskellstack.org/ | sh \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY stack.yaml /root/.stack/global-project/
RUN ["stack", "install", "hlint", "stylish-haskell"]
