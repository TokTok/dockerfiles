# Build the base image in a single layer instead of 100 as done by arion.
FROM scratch
ADD squashed.tar /
# Reinstate the CMD directive from the squashed image.
CMD ["/usr/sbin/init"]

# Using WORKDIR as a built-in "mkdir", because the symlinks to mkdir aren't
# set up yet.
WORKDIR /run/wrappers

ENV PATH="/nix/store/ahkfdxq8mcpsb5kvdvgqr1wv8zjngbh4-coreutils-9.1/bin"

# Required by the activation script
RUN ["install", "-m", "0755", "-d", "/etc", "/etc/nixos"]
RUN ["install", "-m", "01777", "-d", "/tmp"]

# Run the script that performs all configuration activation that does
# not have to be done at boot time.
RUN ["cut", "-d\n", "-f3", "/usr/sbin/init"]
RUN ["/nix/store/v94y1gv5bzyjm5k9d2ngc0712s1da5jc-nixos-system-unnamed-23.05pre-git/activate"]

USER builder
ENV USER="builder" \
    PATH="/run/wrappers/bin:/etc/profiles/per-user/builder/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
