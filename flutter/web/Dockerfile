FROM ubuntu:20.04

ENV DEBIAN_FRONTEND="noninteractive"

# Install flutter dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
 ca-certificates \
 curl \
 fonts-droid-fallback \
 gdb \
 git \
 lib32stdc++6 \
 libgconf-2-4 \
 libglu1-mesa \
 libstdc++6 \
 python3 \
 unzip \
 wget \
 xz-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Clone the flutter repo
RUN ["git", "clone", "--depth=1", "https://github.com/flutter/flutter.git", "/usr/local/flutter"]

# Set flutter path
# RUN /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN ["flutter", "doctor", "-v"]
# Enable flutter web
RUN ["flutter", "channel", "master"]
RUN ["flutter", "config", "--enable-web"]
# Fix ownership: flutter extracts a tarball with some arbitrary UID/GID.
RUN find /usr/local -not -uid 0 -or -not -gid 0 -print0 | xargs -0 chown root:root
