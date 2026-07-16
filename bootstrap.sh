#!/usr/bin/env bash
set -euo pipefail

REPO="git@github.com:apj/cm.git"
BACKUP_HOST="tailinsula"
BACKUP_SHARE="/volume1/NetBackup"
MOUNT="/mnt/netbackup"
BACKUP_HOME="${MOUNT}/$(hostname -s)/home"
BOOTSTRAP_ITEMS=(
    ".ssh"
)

restore_file() {
    local item="$1"

    if [[ -e "${BACKUP_HOME}/${item}" ]]; then
        cp -a "${BACKUP_HOME}/${item}" "$HOME/"
        echo "Restored $item"
    else
        echo "Warning: $item not found"
    fi
}

sudo apt update

sudo apt install -y \
    git \
    nfs-common

sudo mkdir -p "$MOUNT"
mountpoint -q "$MOUNT" || \
    sudo mount -t nfs "${BACKUP_HOST}:${BACKUP_SHARE}" "$MOUNT"

for item in "${BOOTSTRAP_ITEMS[@]}"; do
    restore_file "$item"
done

git clone "$REPO"

cd cm

./restore.sh
