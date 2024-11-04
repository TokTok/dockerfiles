#!/bin/bash
# Copyright (C) 2018-2023 nurupo

# Common variables and functions

NPROC="$(nproc)"

SCREEN_SESSION=freebsd
SSH_PORT=10022

FREEBSD_VERSION="14.1"
IMAGE_NAME="FreeBSD-$FREEBSD_VERSION-RELEASE-amd64.qcow2"
# https://download.freebsd.org/ftp/releases/VM-IMAGES/14.1-RELEASE/amd64/Latest/
IMAGE_SHA512="0d0c1d4f6da27f28aae5e678bedc0d784694e06317ce46ccb6fcc6262d2ef8273296474c086fde4030af0c2f8e81f276ec9bad8563f557514accadf80831678f"
