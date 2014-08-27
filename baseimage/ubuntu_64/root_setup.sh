#!/bin/bash

set -e

# Updating and Upgrading dependencies
sudo apt-get update -y -qq > /dev/null
sudo apt-get upgrade -y -qq > /dev/null

# Set timezone
echo "America/Los_Angeles" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
apt-get -y install ntp

# Install necessary libraries for guest additions
sudo apt-get -y -q install linux-headers-$(uname -r) build-essential dkms

# Install basic tools
sudo apt-get -y -q install curl wget git vim

# Setup sudo to allow no-password sudo for "admin"
groupadd -r admin
usermod -a -G admin gfdev
cp /etc/sudoers /etc/sudoers.orig
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

