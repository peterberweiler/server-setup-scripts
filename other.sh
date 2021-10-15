#!/bin/sh
# setup ufw
set -e

if [ "$(id -u)" -ne 0 ]; then
        echo "This script must be run by root" >&2
        exit 1
fi

sudo apt-get update
sudo apt-get install -y git nano htop


