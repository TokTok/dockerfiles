#!/bin/bash
# Copyright (C) 2018-2021 nurupo

. cmake-freebsd-env.sh

RUN() {
  ssh -t -o ConnectionAttempts=120 -o ConnectTimeout=2 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost -p "$SSH_PORT" "$@"
}

start_vm() {
  if [ -e /dev/kvm ]; then
    screen -d -m qemu-system-x86_64 -curses -m 2048 -smp "$NPROC" -net user,hostfwd=tcp::"$SSH_PORT"-:22 -net nic "$IMAGE_NAME" --enable-kvm
  else
    screen -d -m qemu-system-x86_64 -curses -m 2048 -smp "$NPROC" -net user,hostfwd=tcp::"$SSH_PORT"-:22 -net nic "$IMAGE_NAME"
  fi

  # Wait for 5 minutes for ssh to start listening on the port
  for _ in {1..60}; do
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
  for _ in {1..60}; do
    if ! pgrep qemu; then
      break
    fi
    sleep 5
  done
}
