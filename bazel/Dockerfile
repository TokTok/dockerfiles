# Build the base image in a single layer instead of 100 as done by arion.
FROM scratch
# hadolint ignore=DL3022
COPY --from=base / /
# Reinstate the CMD directive from the squashed image.
CMD ["/usr/sbin/init"]

# We need to know where our bash is, because we haven't set up /bin/sh yet.
# ENV NIXOS_VERSION="24.05"
# SHELL ["/nix/store/rdd4pnr4x9rqc9wgbibhngv217w2xvxl-bash-interactive-5.2p26/bin/bash", "-o", "pipefail", "-c"]
ENV NIXOS_VERSION="23.11"
SHELL ["/nix/store/x88ivkf7rmrhd5x3cvyv5vh3zqqdnhsk-bash-interactive-5.2-p15/bin/bash", "-o", "pipefail", "-c"]

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
