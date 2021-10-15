#!/bin/sh
# setup ufw
set -e

if [ "$(id -u)" -ne 0 ]; then
        echo "This script must be run by root" >&2
        exit 1
fi

sudo apt-get update
sudo apt-get install -y ufw

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh/tcp
sudo ufw allow http/tcp
sudo ufw allow https/tcp

echo "y" | sudo ufw enable

echo "Set up ufw"
sudo ufw status verbose