#!/bin/bash
# Copyright (C) 2018-2023 nurupo

SSH_PORT=10022

RUN() {
  ssh -t -o ConnectionAttempts=120 -o ConnectTimeout=2 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost -p "$SSH_PORT" "$@"
}

start_vm() {
  screen -d -m qemu-system-s390x -nographic -m 2048 -net user,hostfwd=tcp::"$SSH_PORT"-:22 -net nic -hda hda.qcow -loadvm login

  # Wait for 5 minutes for ssh to start listening on the port
  for _ in {1..60}; do
    if echo "exit" | nc localhost "$SSH_PORT" | grep 'OpenSSH'; then
      break
    fi
    sleep 5
  done

  # Test that ssh works
  RUN uname -a
}
