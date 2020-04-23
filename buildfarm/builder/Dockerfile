FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 binutils \
 curl \
 libstdc++-5-dev \
 openjdk-8-jdk-headless \
 libc6-dev \
 python3 \
 python3.5-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/clang_rc47f971694be0159ffddfee8a75ae515eba91439.tar.gz | tar zxv -C /usr/local/
RUN curl https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/libcxx-msan_rc47f971694be0159ffddfee8a75ae515eba91439.tar.gz | tar zxv -C /usr/local/
