# Build webui.
FROM debian:stretch as webui

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 asciidoc \
 bison \
 build-essential \
 default-jdk \
 flex \
 git \
 graphviz \
 source-highlight \
 unzip \
 wget \
 zip \
 zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/bazelbuild/bazel/releases/download/3.1.0/bazel_3.1.0-linux-x86_64.deb \
 && dpkg -i bazel_3.1.0-linux-x86_64.deb \
 && rm bazel_3.1.0-linux-x86_64.deb

WORKDIR /src/kythe
RUN git clone --depth=1 https://github.com/kythe/kythe /src/kythe
RUN CC=gcc CXX=g++ bazel build //kythe/web/ui

RUN mkdir /data \
 && cp -a kythe/web/ui/resources /data/ \
 && cp -a bazel-bin/kythe/web/ui/resources /data/
