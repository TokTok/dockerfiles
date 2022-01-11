# Build webui.
FROM debian:stretch

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 asciidoc \
 bison \
 build-essential \
 default-jdk-headless \
 flex \
 git \
 graphviz \
 python3 \
 ruby \
 source-highlight \
 unzip \
 wget \
 zip \
 zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/bazelbuild/bazel/releases/download/4.2.0/bazel_4.2.0-linux-x86_64.deb \
 && dpkg -i bazel_4.2.0-linux-x86_64.deb \
 && rm bazel_4.2.0-linux-x86_64.deb

WORKDIR /src/kythe
RUN git clone --depth=1 https://github.com/kythe/kythe /src/kythe
RUN CC=gcc CXX=g++ bazel build //kythe/web/ui

RUN mkdir /data \
 && cp -a kythe/web/ui/resources /data/ \
 && cp -a bazel-bin/kythe/web/ui/resources /data/
