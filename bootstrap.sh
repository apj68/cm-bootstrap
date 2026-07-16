#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/apj/cm.git"
BACKUP_HOST="tailinsula"
BACKUP_SHARE="/volume1/NetBackup"
MOUNT="/mnt/netbackup"

sudo apt update

sudo apt install -y \
    git \
    nfs-common

git clone "$REPO"

cd cm

./restore.sh
