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
