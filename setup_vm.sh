#!/bin/bash

# Upgrade the OS, kernel and install Docker
export DEBIAN_FRONTEND=noninteractive

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo 'deb     "https://apt.dockerproject.org/repo" ubuntu-trusty main' > /etc/apt/sources.list.d/docker-main.list
apt-get update || exit 1
apt-get upgrade -y || exit 1

apt-get install -y linux-virtual-lts-wily linux-image-extra-virtual-lts-wily
apt-get install -y docker-engine=1.10.3-0~trusty

# Copy /vagrant as the upgrade reboot breaks it
cp -r /vagrant /tests
# Drop a symlink in ~vagrant for ease
ln -s /tests/run_test.sh ~vagrant/run_test.sh

# Reboot into 4.2 kernel
reboot
