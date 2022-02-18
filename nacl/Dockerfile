################################################
# autotools-linux
FROM ubuntu:20.04

RUN apt-get update && apt-get install --no-install-recommends -y \
 autoconf \
 automake \
 ca-certificates \
 curl \
 libconfig-dev \
 libmsgpack-dev \
 libopus-dev \
 libtool \
 libvpx-dev \
 make \
 pkg-config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd -r -g 1000 builder \
 && useradd -m --no-log-init -r -g builder -u 1000 builder
USER builder

ENV CACHEDIR=/home/builder/cache

WORKDIR /home/builder
COPY --chown=builder:builder install-nacl.sh /home/builder/
RUN ["/home/builder/install-nacl.sh"]
