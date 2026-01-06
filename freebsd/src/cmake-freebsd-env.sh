#!/bin/bash
# Copyright (C) 2018-2023 nurupo

# Common variables and functions

NPROC="$(nproc)"

SCREEN_SESSION=freebsd
SSH_PORT=10022

FREEBSD_VERSION="14.3"
IMAGE_NAME="FreeBSD-$FREEBSD_VERSION-RELEASE-amd64.qcow2"
# https://download.freebsd.org/ftp/releases/VM-IMAGES/14.3-RELEASE/amd64/Latest/
IMAGE_SHA512="9024ea7060181855ee5582d52d015e03672a046ce755000c30b2298813dc956effbaf505d750412cf04697c8970d6b11b1db12e18ad0df58d9f691ce20dddea0"
