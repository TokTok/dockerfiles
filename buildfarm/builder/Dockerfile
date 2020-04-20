FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 binutils=2.26.1-1ubuntu1~16.04.8 \
 curl=7.47.0-1ubuntu2.14 \
 libstdc++-5-dev=5.4.0-6ubuntu1~16.04.12 \
 openjdk-8-jdk-headless=8u242-b08-0ubuntu3~16.04 \
 libc6-dev=2.23-0ubuntu11 \
 python3=3.5.1-3 \
 python3.5-dev=3.5.2-2ubuntu0~16.04.10 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/clang_rc47f971694be0159ffddfee8a75ae515eba91439.tar.gz | tar zxv -C /usr/local/
RUN curl https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/libcxx-msan_rc47f971694be0159ffddfee8a75ae515eba91439.tar.gz | tar zxv -C /usr/local/
