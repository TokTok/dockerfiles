FROM ubuntu:22.04

# Step 1: Install QEMU
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 ca-certificates \
 expect \
 ipxe-qemu \
 qemu-system-s390x \
 qemu-utils \
 screen \
 seabios \
 ssh \
 vgabios \
 wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work

# Step 2: Download Linux kernel and installation image
RUN ["wget", "https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/s390x/netboot/vmlinuz-lts"]
RUN ["wget", "https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/s390x/netboot/initramfs-lts"]

# Step 3: Create a new hard disk
RUN ["qemu-img", "create", "-f", "qcow2", "hda.qcow", "8G"]

COPY src/cmake-alpine-env.sh \
     src/setup-vm \
     src/setup-vm.expect \
     /work/

# Step 4: Install Alpine Linux/s390x
RUN ["./setup-vm"]
