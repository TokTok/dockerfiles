# Download instead of build it ourselves.
FROM ubuntu:22.04

# Retry downloads that fail for a moment, e.g. GitHub's occasional HTTP 500.
# The settings apply while building this image, not in the image itself.
ARG CURL_HOME=/etc/download-retry
ARG WGETRC=/etc/download-retry/wgetrc
RUN mkdir -p /etc/download-retry \
 && printf 'retry = 5\nretry-delay = 10\nretry-connrefused\nretry-all-errors\nfail\n' >/etc/download-retry/.curlrc \
 && printf 'tries = 5\nwaitretry = 10\nretry_connrefused = on\nretry_on_http_error = 429,500,502,503,504\n' >/etc/download-retry/wgetrc

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
