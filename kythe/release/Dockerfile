# Download instead of build it ourselves.
FROM ubuntu:22.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 ca-certificates \
 wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget -q -O /tmp/kythe.tar.gz https://github.com/kythe/kythe/releases/download/v0.0.63/kythe-v0.0.63.tar.gz
RUN tar --no-same-owner -xvzf /tmp/kythe.tar.gz --directory /opt
RUN mv /opt/kythe-v0.0.63 /opt/kythe
# Fix rust toolchain path.
RUN sed -i -e 's/rust_linux_x86_64__x86_64-unknown-linux-gnu_tools/rust_linux_x86_64__x86_64-unknown-linux-gnu__stable_tools/' /opt/kythe/BUILD
