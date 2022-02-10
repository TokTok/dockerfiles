FROM ubuntu:20.04

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
 ca-certificates \
 cmake \
 curl \
 git \
 libmsgpack-dev \
 libopus-dev \
 libsodium-dev \
 libtinfo-dev \
 libvpx-dev \
 ninja-build \
 pkg-config \
 && curl -sSL https://get.haskellstack.org/ | sh \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work
RUN git clone https://github.com/TokTok/c-toxcore /work \
 && cmake -B_build -H. -GNinja -DCMAKE_INSTALL_PREFIX:PATH="/usr" \
 && cmake --build _build --parallel "$(nproc)" --target install \
 && rm -rf /work \
 && ldconfig

RUN useradd -m -g users -G sudo -u 1001 builder \
 && chown builder:users /work \
 && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder

COPY --chown=builder:users stack.yaml /work/
RUN grep '^  -.*/' stack.yaml \
 | awk '{print $2}' \
 | grep -o '[^/]*' \
 | xargs -P8 -n1 -I '{}' git clone --depth=1 'https://github.com/TokTok/{}'
RUN ["stack", "install"]
