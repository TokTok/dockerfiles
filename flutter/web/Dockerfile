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

RUN groupadd -r -g 1000 builder \
 && useradd -m --no-log-init -r -g builder -u 1000 builder
USER builder
WORKDIR /home/builder

# Clone the flutter repo
RUN ["git", "clone", "--depth=1000", "https://github.com/flutter/flutter.git", "/home/builder/flutter"]

# Set flutter path
# RUN /home/builder/flutter/bin/flutter doctor -v
ENV PATH="/home/builder/flutter/bin:/home/builder/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN ["flutter", "doctor", "-v"]
# Enable flutter web
RUN ["flutter", "channel", "master"]
RUN ["flutter", "config", "--enable-web"]
