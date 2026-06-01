#!/bin/bash

JOB_NAME="$1"
BUILD_NUMBER="$2"

BUCKET="panigrahan-tf-and-logs-backup"

LOG_FILE="/var/lib/jenkins/jobs/${JOB_NAME}/builds/${BUILD_NUMBER}/log"

if [ -f "$LOG_FILE" ]; then

    aws s3 cp \
    "$LOG_FILE" \
    "s3://${BUCKET}/logs/jenkins-builds/${JOB_NAME}/build-${BUILD_NUMBER}.log"

    echo "Uploaded build log for ${JOB_NAME} build ${BUILD_NUMBER}"

else

    echo "Build log not found: ${LOG_FILE}"

fi