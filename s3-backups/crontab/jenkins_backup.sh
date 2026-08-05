#!/bin/bash
set -uo pipefail

DATE=$(date +%F-%H-%M-%S)
BACKUP_DIR="/tmp/jenkins-backup-$DATE"

# Always clean up the temp dir on exit, even on failure or interruption
trap 'rm -rf "$BACKUP_DIR"' EXIT

# Safety net: remove any orphaned backups left by past failed runs
find /tmp -maxdepth 1 -type d -name 'jenkins-backup-*' -mtime +1 -exec rm -rf {} \;

mkdir -p "$BACKUP_DIR"

echo "=================================================="
echo "TAKING JENKINS BACKUP"
echo "=================================================="
sudo cp -r /var/lib/jenkins/jobs    "$BACKUP_DIR/"
sudo cp -r /var/lib/jenkins/users   "$BACKUP_DIR/" || true
sudo cp -r /var/lib/jenkins/plugins "$BACKUP_DIR/" || true
sudo cp /var/lib/jenkins/config.xml "$BACKUP_DIR/" || true

echo "=================================================="
echo "UPLOADING TO S3"
echo "=================================================="
if aws s3 cp "$BACKUP_DIR" \
    "s3://panigrahan-tf-and-logs-backup/jenkins-backups/$DATE/" \
    --recursive; then
    echo "S3 upload succeeded"
else
    echo "ERROR: S3 upload failed" >&2
    exit 1
fi

echo "=================================================="
echo "BACKUP COMPLETED (temp files cleaned up via trap)"
echo "=================================================="