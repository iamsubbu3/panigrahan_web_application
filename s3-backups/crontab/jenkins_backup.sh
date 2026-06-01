#!/bin/bash

DATE=$(date +%F-%H-%M-%S)

BACKUP_DIR="/tmp/jenkins-backup-$DATE"

mkdir -p $BACKUP_DIR

echo "=================================================="

echo "TAKING JENKINS BACKUP"

echo "=================================================="

sudo cp -r /var/lib/jenkins/jobs $BACKUP_DIR/

sudo cp -r /var/lib/jenkins/users $BACKUP_DIR/ || true

sudo cp -r /var/lib/jenkins/plugins $BACKUP_DIR/ || true

sudo cp /var/lib/jenkins/config.xml $BACKUP_DIR/ || true

echo "=================================================="

echo "UPLOADING TO S3"

echo "=================================================="

aws s3 cp $BACKUP_DIR \
s3://panigrahan-tf-and-logs-backup/jenkins-backups/$DATE/ \
--recursive

echo "=================================================="

echo "CLEANING LOCAL TEMP FILES"

echo "=================================================="

rm -rf $BACKUP_DIR

echo "=================================================="

echo "BACKUP COMPLETED"

echo "=================================================="