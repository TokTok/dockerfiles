FROM ubuntu:16.04 AS build

RUN apt-get update && apt-get install --no-install-recommends -y \
 ca-certificates \
 g++ \
 git \
 openjdk-8-jdk-headless \
 unzip \
 wget \
 zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install bazel.
RUN wget -q https://github.com/bazelbuild/bazel/releases/download/3.1.0/bazel_3.1.0-linux-x86_64.deb \
 && dpkg -i bazel_3.1.0-linux-x86_64.deb \
 && rm bazel_3.1.0-linux-x86_64.deb

# Download and build buildfarm.
RUN ["git", "clone", "--depth=1",\
 "https://github.com/bazelbuild/bazel-buildfarm", "/src/bazel-buildfarm"]
WORKDIR /src/bazel-buildfarm
RUN ["bazel", "build",\
 "//src/main/java/build/buildfarm:buildfarm-server_deploy.jar",\
 "//src/main/java/build/buildfarm:buildfarm-operationqueue-worker_deploy.jar",\
 "//src/main/java/build/buildfarm:buildfarm-shard-worker_deploy.jar"]
RUN ["cp",\
 "bazel-bin/src/main/java/build/buildfarm/buildfarm-server_deploy.jar",\
 "bazel-bin/src/main/java/build/buildfarm/buildfarm-operationqueue-worker_deploy.jar",\
 "bazel-bin/src/main/java/build/buildfarm/buildfarm-shard-worker_deploy.jar",\
 "/"]

# Produce a minimal image with just the jars in it.
FROM scratch
COPY --from=build \
       /buildfarm-server_deploy.jar \
       /buildfarm-operationqueue-worker_deploy.jar \
       /buildfarm-shard-worker_deploy.jar \
       /
