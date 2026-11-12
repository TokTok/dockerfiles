# Build webui on ubuntu 20.04 because we need Java 8, not newer.
FROM ubuntu:20.04

# Retry downloads that fail for a moment, e.g. GitHub's occasional HTTP 500.
# The settings apply while building this image, not in the image itself.
ARG CURL_HOME=/etc/download-retry
ARG WGETRC=/etc/download-retry/wgetrc
RUN mkdir -p /etc/download-retry \
 && printf 'retry = 5\nretry-delay = 10\nretry-connrefused\nretry-all-errors\nfail\n' >/etc/download-retry/.curlrc \
 && printf 'tries = 5\nwaitretry = 10\nretry_connrefused = on\nretry_on_http_error = 429,500,502,503,504\n' >/etc/download-retry/wgetrc

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 asciidoc \
 bison \
 build-essential \
 openjdk-8-jdk-headless \
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

RUN wget -q https://github.com/bazelbuild/bazel/releases/download/5.0.0/bazel_5.0.0-linux-x86_64.deb \
 && dpkg -i bazel_5.0.0-linux-x86_64.deb \
 && rm bazel_5.0.0-linux-x86_64.deb

WORKDIR /src/kythe
RUN git clone --depth=1 --branch=v0.0.60 https://github.com/kythe/kythe /src/kythe
RUN CC=gcc CXX=g++ bazel build //kythe/web/ui

RUN mkdir /data \
 && cp -a kythe/web/ui/resources /data/ \
 && cp -a bazel-bin/kythe/web/ui/resources /data/
