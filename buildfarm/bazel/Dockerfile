FROM toxchat/builder:latest

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Bazel.
RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
 apt-transport-https \
 apt-utils \
 git \
 gnupg \
 wget \
 && curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg \
 && mv bazel.gpg /etc/apt/trusted.gpg.d/ \
 && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
 && apt-get update && apt-get install -y --no-install-recommends \
 bazel=4.2.2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
