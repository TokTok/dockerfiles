#!/bin/bash

PASSWORD=adb
USER=androidbuilder
HOME=/home/$USER
INSTALL="install -o $USER -g $USER"

deluser $USER --remove-home 2>/dev/null
rm -rf $HOME
cat <<EOF | adduser $USER --gecos $USER 2>&1
$PASSWORD
$PASSWORD
EOF

apt-get install sed # just in case
echo "--------------------------"
cat /etc/apt/sources.list
echo "--------------------------"
sed -i -e 'sx^# debxdebxg' /etc/apt/sources.list
echo "--------------------------"
cat /etc/apt/sources.list
echo "--------------------------"

apt-get update

apt-get install wget
apt-get update
