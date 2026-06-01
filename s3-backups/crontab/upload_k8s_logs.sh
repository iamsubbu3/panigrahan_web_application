#!/bin/bash

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

DATE=$(date +%F-%H-%M-%S)

TEMP_DIR="/tmp/k8s-logs-$DATE"

mkdir -p $TEMP_DIR

echo "=================================================="

echo "COLLECTING KUBERNETES LOGS"

echo "=================================================="

/usr/local/bin/kubectl logs deployment/frontend \
-n panigrahan > $TEMP_DIR/frontend.log 2>&1 || true

/usr/local/bin/kubectl logs deployment/backend \
-n panigrahan > $TEMP_DIR/backend.log 2>&1 || true

/usr/local/bin/kubectl logs statefulset/mysql \
-n panigrahan > $TEMP_DIR/mysql.log 2>&1 || true

echo "=================================================="

echo "UPLOADING LOGS TO S3"

echo "=================================================="

/usr/local/bin/aws s3 cp $TEMP_DIR \
s3://panigrahan-tf-and-logs-backup/production-logs/$DATE/ \
--recursive

echo "=================================================="

echo "CLEANING TEMP FILES"

echo "=================================================="

rm -rf $TEMP_DIR

echo "=================================================="

echo "PRODUCTION LOG UPLOAD COMPLETED"

echo "=================================================="