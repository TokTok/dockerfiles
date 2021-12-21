FROM toxchat/freebsd:layered as build
FROM ubuntu:20.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 ca-certificates \
 git \
 netcat \
 qemu \
 qemu-system-x86 \
 screen \
 ssh \
 wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY --from=build /work /work
