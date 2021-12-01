# Download instead of build it ourselves.
FROM ubuntu:20.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 ca-certificates \
 wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget -q -O /tmp/kythe.tar.gz https://github.com/kythe/kythe/releases/download/v0.0.55/kythe-v0.0.55.tar.gz
RUN tar --no-same-owner -xvzf /tmp/kythe.tar.gz --directory /opt
RUN mv /opt/kythe-v0.0.55 /opt/kythe
