#!/bin/bash

VERSION="$1"
BUILD_NUMBER="$2"
STATUS="$3"

BUCKET="panigrahan-tf-and-logs-backup"

cat > /tmp/release-info.txt <<EOF
==================================================
PANIGRAHAN RELEASE INFORMATION
==================================================

Release Version : ${VERSION}

Build Number    : ${BUILD_NUMBER}

Deployment Time : $(TZ=Asia/Kolkata date)

Deployment Status : ${STATUS}

Frontend Image :
iamsubbu3/panigrahan-frontend:${VERSION}

Backend Image :
iamsubbu3/panigrahan-backend:${VERSION}

==================================================
EOF

aws s3 cp \
/tmp/release-info.txt \
"s3://${BUCKET}/logs/jenkins-builds/Panigrahan_release_multibranch/${VERSION}/release-info.txt"

echo "Release information uploaded to S3"