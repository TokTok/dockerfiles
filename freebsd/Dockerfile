FROM ubuntu:22.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 ca-certificates \
 expect \
 git \
 netcat \
 qemu \
 qemu-system-x86 \
 qemu-utils \
 screen \
 ssh \
 wget \
 xz-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work

COPY src/cmake-freebsd-env.sh \
     src/cmake-freebsd-run.sh \
     src/setup-vm \
     src/setup-vm.expect \
     /work/

RUN ["./setup-vm"]
