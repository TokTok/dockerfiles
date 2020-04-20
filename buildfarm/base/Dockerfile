FROM ubuntu:16.04 AS build

RUN apt-get update && apt-get install --no-install-recommends -y \
 ca-certificates=20170717~16.04.2 \
 g++=4:5.3.1-1ubuntu1 \
 git=1:2.7.4-0ubuntu1.9 \
 openjdk-8-jdk-headless=8u242-b08-0ubuntu3~16.04 \
 unzip=6.0-20ubuntu1 \
 wget=1.17.1-1ubuntu1.5 \
 zlib1g-dev=1:1.2.8.dfsg-2ubuntu4.3 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install bazel.
RUN wget -q https://github.com/bazelbuild/bazel/releases/download/3.0.0/bazel_3.0.0-linux-x86_64.deb \
 && dpkg -i bazel_3.0.0-linux-x86_64.deb \
 && rm bazel_3.0.0-linux-x86_64.deb

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
