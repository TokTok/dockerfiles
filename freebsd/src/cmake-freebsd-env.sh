#!/bin/bash
# Copyright (C) 2018-2023 nurupo

# Common variables and functions

NPROC="$(nproc)"

SCREEN_SESSION=freebsd
SSH_PORT=10022

FREEBSD_VERSION="14.0"
IMAGE_NAME="FreeBSD-$FREEBSD_VERSION-RELEASE-amd64.qcow2"
# https://download.freebsd.org/ftp/releases/VM-IMAGES/14.0-RELEASE/amd64/Latest/
IMAGE_SHA512="4fe194b45a57c601bbc9e48d6f653b461e040757383cc0d690718e9f726e3b799074aa408e10e544ca3e988a822f42d7204ec660d43533d927fa7503db0fca83"
