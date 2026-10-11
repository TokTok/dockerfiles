FROM ghcr.io/toktok/bazel:base AS base
# Build the base image in a single layer instead of 100 as done by arion.
FROM scratch
# hadolint ignore=DL3022,DL3067
COPY --from=base / /
# Reinstate the CMD directive from the squashed image.
CMD ["/usr/sbin/init"]

# We need to know where our bash is, because we haven't set up /bin/sh yet.
ENV NIXOS_VERSION="9fbb54b33e91ee4ca368e35a78e0613c720600b3"
SHELL ["/nix/store/7a60q5dgnv6z96c279rc1nalyiw4mgqn-bash-interactive-5.3p15/bin/bash", "-o", "pipefail", "-c"]

# Run activation script (init knows where it is).
RUN /usr/sbin/init || true
ENV PATH="/etc/profiles/per-user/builder/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"

# Create suid/sgid wrappers so sudo works in the rest of the docker build.
WORKDIR /run/wrappers
RUN "$(grep -o '/nix/store/.*/suid-sgid-wrappers-start' /etc/systemd/system/suid-sgid-wrappers.service)"

WORKDIR /home/builder
# hadolint ignore=DL3066
USER builder
ENV USER="builder" PATH="/run/wrappers/bin:$PATH"

# Test whether the suid/sgid wrapper script worked.
RUN ["sudo", "true"]
RUN ["bazel", "--version"]
