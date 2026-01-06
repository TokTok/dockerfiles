FROM ghcr.io/toktok/bazel:913b05c1lqrbd4ac130l6zvzy1bzhc7f AS base
# Build the base image in a single layer instead of 100 as done by arion.
FROM scratch
# hadolint ignore=DL3022
COPY --from=base / /
# Reinstate the CMD directive from the squashed image.
CMD ["/usr/sbin/init"]

# We need to know where our bash is, because we haven't set up /bin/sh yet.
ENV NIXOS_VERSION="3a7affa77a5a539afa1c7859e2c31abdb1aeadf3"
SHELL ["/nix/store/35yc81pz0q5yba14lxhn5r3jx5yg6c3l-bash-interactive-5.3p3/bin/bash", "-o", "pipefail", "-c"]

# Run activation script (init knows where it is).
RUN /usr/sbin/init || true
ENV PATH="/etc/profiles/per-user/builder/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"

# Create suid/sgid wrappers so sudo works in the rest of the docker build.
WORKDIR /run/wrappers
RUN "$(grep -o '/nix/store/.*/suid-sgid-wrappers-start' /etc/systemd/system/suid-sgid-wrappers.service)"

WORKDIR /home/builder
USER builder
ENV USER="builder" PATH="/run/wrappers/bin:$PATH"

# Test whether the suid/sgid wrapper script worked.
RUN ["sudo", "true"]
RUN ["bazel", "--version"]
