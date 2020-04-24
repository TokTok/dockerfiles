#!/bin/sh

echo "--------------------------"
cat /etc/apt/sources.list
echo "--------------------------"
sed -i -e 'sx^# debxdebxg' /etc/apt/sources.list
echo "--------------------------"
cat /etc/apt/sources.list
echo "--------------------------"

apt-get update
