FROM debian:bullseye-slim

LABEL maintainer "Infer team"

# mkdir the man/man1 directory due to Debian bug #863199
RUN apt-get update \
 && mkdir -p /usr/share/man/man1 \
 && apt-get install --yes --no-install-recommends \
 curl \
 libc6-dev \
 libconfig-dev \
 libmsgpack-dev \
 libopus-dev \
 libsodium-dev \
 libvpx-dev \
 openjdk-11-jdk-headless \
 sqlite3 \
 xz-utils \
 zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

# Download the Infer release
WORKDIR /opt
ENV INFER_VERSION=v1.1.0
RUN bash -c "tar Jxf <(curl -sL 'https://github.com/facebook/infer/releases/download/$INFER_VERSION/infer-linux64-$INFER_VERSION.tar.xz')" \
 && rm -f /infer \
 && ln -s "$PWD/infer-linux64-$INFER_VERSION" /infer

# Install infer
ENV PATH /infer/bin:$PATH
