#!/bin/bash

DATE=$(date +%F-%H-%M-%S)

TEMP_DIR="/tmp/jenkins-logs-$DATE"

mkdir -p $TEMP_DIR

echo "=================================================="

echo "COLLECTING JENKINS LOGS"

echo "=================================================="

sudo cp -r /var/log/jenkins $TEMP_DIR/ || true

sudo cp -r /var/lib/jenkins/jobs $TEMP_DIR/jobs || true

echo "=================================================="

echo "UPLOADING JENKINS LOGS TO S3"

echo "=================================================="

aws s3 cp $TEMP_DIR \
s3://panigrahan-tf-and-logs-backup/jenkins-logs/$DATE/ \
--recursive

echo "=================================================="

echo "CLEANING TEMP FILES"

echo "=================================================="

rm -rf $TEMP_DIR

echo "=================================================="

echo "JENKINS LOG UPLOAD COMPLETED"

echo "=================================================="