#!/usr/bin/env bash
set -euo pipefail

REPO="git@github.com/apj/cm.git"
BACKUP_HOST="tailinsula"
BACKUP_SHARE="/volume1/NetBackup"
MOUNT="/mnt/netbackup"

restore_file() {
    cp -pr $1 $HOME
}

sudo apt update

sudo apt install -y \
    git \
    nfs-common

sudo mount -t nfs ${BACKUP_HOST}:${BACKUP_SHARE} $MOUNT

restore_file ".ssh"
restore_file ".gitconfig"
restore_file ".profile"
restore_file ".aliases"

git clone "$REPO"

cd cm

./restore.sh
