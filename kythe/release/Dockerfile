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
# Disable rust and typescript extractors (we don't use these languages).
RUN sed -E -i -e '/:extract_kzip_(rust|typescript)/ s/^/#/' /opt/kythe/extractors.bazelrc
