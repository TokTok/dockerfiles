# The build environment for toktok-stack builds.
# We're building this separately so the rebuild is minimal.
FROM ghcr.io/toktok/kythe-release:latest AS release
FROM ghcr.io/toktok/bazel:latest

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends parallel \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY --from=release /opt/kythe /opt/kythe
COPY build_index.sh /opt/

WORKDIR /src/workspace
