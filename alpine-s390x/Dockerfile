FROM ubuntu:22.04

# Retry downloads that fail for a moment, e.g. GitHub's occasional HTTP 500.
# The settings apply while building this image, not in the image itself.
ARG CURL_HOME=/etc/download-retry
ARG WGETRC=/etc/download-retry/wgetrc
RUN mkdir -p /etc/download-retry \
 && printf 'retry = 5\nretry-delay = 10\nretry-connrefused\nretry-all-errors\nfail\n' >/etc/download-retry/.curlrc \
 && printf 'tries = 5\nwaitretry = 10\nretry_connrefused = on\nretry_on_http_error = 429,500,502,503,504\n' >/etc/download-retry/wgetrc

# Step 1: Install QEMU
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 ca-certificates \
 expect \
 ipxe-qemu \
 netcat \
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
RUN ["wget", "-q", "https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/s390x/netboot/vmlinuz-lts"]
RUN ["wget", "-q", "https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/s390x/netboot/initramfs-lts"]

# Step 3: Create a new hard disk
RUN ["qemu-img", "create", "-f", "qcow2", "hda.qcow", "8G"]

COPY src/setup-vm \
     src/setup-vm.expect \
     /work/

# Step 4: Install Alpine Linux/s390x
RUN ["./setup-vm"]

COPY src/id_rsa /root/.ssh/id_rsa
RUN ["chmod", "600", "/root/.ssh/id_rsa"]

COPY src/cmake-alpine-run.sh \
     src/test-vm \
     /work/
RUN ["./test-vm"]
