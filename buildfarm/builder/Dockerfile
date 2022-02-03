FROM ubuntu:20.04

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 binutils \
 curl \
 libstdc++-10-dev \
 default-jdk-headless \
 libc6-dev \
 python \
 python3 \
 python3-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN BASE_URL=https://storage.googleapis.com/clang-builds-stable/clang-ubuntu18_04 \
    VERSION=$(curl https://storage.googleapis.com/clang-builds-stable/clang-ubuntu18_04/latest.txt) \
 && bash -c "tar -C /usr/local/ -zxf <(curl '$BASE_URL/clang_r$VERSION.tar.gz')" \
 && bash -c "tar -C /usr/local/ -zxf <(curl '$BASE_URL/libcxx-msan_r$VERSION.tar.gz')" \
 && bash -c "tar -C /usr/local/ -zxf <(curl '$BASE_URL/lld_r$VERSION.tar.gz')"

ENV CC=/usr/local/bin/clang \
    CXX=/usr/local/bin/clang++ \
    JAVA_HOME=/usr/lib/jvm/default-java
