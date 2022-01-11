FROM toxchat/builder:latest

# Install Bazel and toktok-stack dependencies.
RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
 git \
 libasound2-dev \
 libgmp-dev \
 libncurses5-dev \
 libncursesw5-dev \
 libqt5opengl5-dev \
 libqt5svg5-dev \
 libssl-dev \
 libtinfo5 \
 libx264-dev \
 libxcb-xfixes0-dev \
 libxss-dev \
 libxxf86vm-dev \
 make \
 maven \
 qtmultimedia5-dev \
 qttools5-dev \
 qttools5-dev-tools \
 unzip \
 wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && wget -nv https://github.com/bazelbuild/bazelisk/releases/download/v1.11.0/bazelisk-linux-amd64 \
 && chmod 755 bazelisk-linux-amd64 \
 && mv bazelisk-linux-amd64 /usr/local/bin/bazel \
 && bazel --version
