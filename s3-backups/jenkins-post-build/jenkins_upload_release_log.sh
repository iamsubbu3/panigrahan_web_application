#!/bin/bash

JOB_NAME="$1"
BRANCH_NAME="$2"
BUILD_NUMBER="$3"

BUCKET="panigrahan-tf-and-logs-backup"

LOG_FILE="/var/lib/jenkins/jobs/${JOB_NAME}/branches/${BRANCH_NAME}/builds/${BUILD_NUMBER}/log"

if [ -f "$LOG_FILE" ]; then

    aws s3 cp \
    "$LOG_FILE" \
    "s3://${BUCKET}/logs/jenkins-builds/${JOB_NAME}/${BRANCH_NAME}/build-${BUILD_NUMBER}.log"

    echo "Uploaded build log"

else

    echo "Log file not found: $LOG_FILE"

fi