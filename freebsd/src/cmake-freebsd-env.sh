#!/bin/bash
# Copyright (C) 2018-2021 nurupo

# Common variables and functions

NPROC="$(nproc)"

SCREEN_SESSION=freebsd
SSH_PORT=10022

FREEBSD_VERSION="12.3"
IMAGE_NAME="FreeBSD-$FREEBSD_VERSION-RELEASE-amd64.raw"
# https://download.freebsd.org/ftp/releases/VM-IMAGES/12.3-RELEASE/amd64/Latest/
IMAGE_SHA512="29c4b670bd2adbc4f8880ab74e62a1409985af1f76e2ebb160b8a9a9dfc66b741915171401471e45b4dcd59212e1e50c68685f4dbbd96e86b67e56cc26a39017"

RUN() {
  ssh -t -o ConnectionAttempts=120 -o ConnectTimeout=2 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost -p "$SSH_PORT" "$@"
}

start_vm() {
  screen -d -m qemu-system-x86_64 -curses -m 2048 -smp "$NPROC" -net user,hostfwd=tcp::"$SSH_PORT"-:22 -net nic "$IMAGE_NAME"

  # Wait for 5 minutes for ssh to start listening on the port
  for i in $(seq 1 60); do
    if echo "exit" | nc localhost "$SSH_PORT" | grep 'OpenSSH'; then
      break
    fi
    sleep 5
  done

  # Test that ssh works
  RUN uname -a
  RUN last
}

stop_vm() {
  # Turn it off
  # We use this contraption because for some reason `shutdown -h now` and
  # `poweroff` result in FreeBSD not shutting down on Travis (they work on my
  # machine though)
  RUN "shutdown -p +5sec && sleep 30" || true

  # Wait for 5 minutes for the qemu process to terminate
  for i in $(seq 1 60); do
    if ! pgrep qemu; then
      break
    fi
    sleep 5
  done
}
