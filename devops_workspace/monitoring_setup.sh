#!/bin/bash

set -e

# ====================================================
# ZERO-FAIL PROMETHEUS + GRAFANA SETUP
# Prometheus -> ClusterIP
# Grafana    -> NodePort
# ====================================================

NAMESPACE_MON="monitoring"

echo "===================================================="
echo " Starting Monitoring Stack Installation"
echo "===================================================="

# ----------------------------------------------------
# 1️⃣ Cluster Validation
# ----------------------------------------------------

echo "Checking Kubernetes Cluster Connectivity..."

kubectl cluster-info >/dev/null

echo "Cluster Connected Successfully ✅"

# ----------------------------------------------------
# 2️⃣ Install Required Tools
# ----------------------------------------------------

if ! command -v helm >/dev/null 2>&1; then

    echo "Installing Helm..."

    curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

fi

if ! command -v jq >/dev/null 2>&1; then

    echo "Installing jq..."

    sudo apt update -y

    sudo apt install -y jq

fi

# ----------------------------------------------------
# 3️⃣ Add Helm Repository
# ----------------------------------------------------

echo "Adding Helm Repositories..."

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts || true

helm repo update

# ----------------------------------------------------
# 4️⃣ Create Namespace
# ----------------------------------------------------

echo "Creating Monitoring Namespace..."

kubectl create namespace ${NAMESPACE_MON} \
--dry-run=client -o yaml | kubectl apply -f -

# ----------------------------------------------------
# 5️⃣ Create Values File
# ----------------------------------------------------

echo "Creating Helm Values File..."

cat <<EOF > monitoring-values.yaml

grafana:
  service:
    type: NodePort
    nodePort: 32000

prometheus:
  service:
    type: ClusterIP

alertmanager:
  service:
    type: ClusterIP

EOF

# ----------------------------------------------------
# 6️⃣ Cleanup Failed Release
# ----------------------------------------------------

STATUS=$(helm list -n ${NAMESPACE_MON} --all -o json | jq -r '.[] | select(.name=="monitoring") | .status' || true)

if [[ "$STATUS" == "pending-install" || "$STATUS" == "pending-upgrade" || "$STATUS" == "failed" ]]; then

    echo "Cleaning Failed Helm Release..."

    helm uninstall monitoring -n ${NAMESPACE_MON} || true

fi

# ----------------------------------------------------
# 7️⃣ Install Prometheus + Grafana
# ----------------------------------------------------

echo "Installing Prometheus + Grafana..."

helm upgrade --install monitoring \
prometheus-community/kube-prometheus-stack \
-n ${NAMESPACE_MON} \
-f monitoring-values.yaml \
--wait \
--timeout 20m \
--atomic

# ----------------------------------------------------
# 8️⃣ Wait For Pods
# ----------------------------------------------------

echo "Waiting For Pods To Become Ready..."

kubectl wait \
--for=condition=Ready pods \
--all \
-n ${NAMESPACE_MON} \
--timeout=900s || true

# ----------------------------------------------------
# 9️⃣ Display Services
# ----------------------------------------------------

echo ""
echo "===================================================="
echo " Monitoring Services"
echo "===================================================="

kubectl get svc -n ${NAMESPACE_MON}

# ----------------------------------------------------
# 🔟 Get Grafana Admin Password
# ----------------------------------------------------

echo ""
echo "===================================================="
echo " Grafana Admin Password"
echo "===================================================="

kubectl -n ${NAMESPACE_MON} get secret monitoring-grafana \
-o jsonpath="{.data.admin-password}" | base64 -d

echo ""

# ----------------------------------------------------
# 1️⃣1️⃣ Get Worker Node Public IP
# ----------------------------------------------------

echo ""
echo "===================================================="
echo " Worker Node Public IP"
echo "===================================================="

kubectl get nodes -o wide

echo ""
echo "===================================================="
echo " Grafana Access URL"
echo "===================================================="

echo "http://<WORKER-NODE-PUBLIC-IP>:32000"

echo ""
echo "Username: admin"

# ----------------------------------------------------
# 1️⃣2️⃣ Security Group Reminder
# ----------------------------------------------------

echo ""
echo "===================================================="
echo " IMPORTANT SECURITY GROUP CONFIGURATION"
echo "===================================================="

echo "Allow inbound port:"
echo "32000"

echo ""
echo "Protocol: TCP"

echo ""
echo "Source:"
echo "0.0.0.0/0"

# ----------------------------------------------------
# ✅ Completed
# ----------------------------------------------------

echo ""
echo "===================================================="
echo " INSTALLATION COMPLETED SUCCESSFULLY ✅"
echo "===================================================="