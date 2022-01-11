FROM ubuntu:18.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 binutils \
 curl \
 libstdc++-7-dev \
 default-jdk-headless \
 libc6-dev \
 python \
 python3 \
 python3-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN BASE_URL=https://storage.googleapis.com/clang-builds-stable/clang-ubuntu18_04 \
    VERSION=$(curl https://storage.googleapis.com/clang-builds-stable/clang-ubuntu18_04/latest.txt) \
 && curl "$BASE_URL/clang_r$VERSION.tar.gz" | tar zxv -C /usr/local/ \
 && curl "$BASE_URL/libcxx-msan_r$VERSION.tar.gz" | tar zxv -C /usr/local/ \
 && curl "$BASE_URL/lld_r$VERSION.tar.gz" | tar zxv -C /usr/local/

ENV CC=/usr/local/bin/clang CXX=/usr/local/bin/clang++
ENV JAVA_HOME=/usr/lib/jvm/default-java
