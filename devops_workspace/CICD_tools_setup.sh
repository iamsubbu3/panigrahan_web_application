#!/bin/bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "=================================================================="
echo " DevSecOps Setup Script (2026 Updated)"
echo " Docker | Jenkins | SonarQube | Trivy | AWS CLI | kubectl | eksctl"
echo "=================================================================="

# ----------------------------------------------------------
# Verify Ubuntu
# ----------------------------------------------------------

if ! command -v apt >/dev/null 2>&1; then
    echo "❌ Ubuntu/Debian system required"
    exit 1
fi

# ----------------------------------------------------------
# Detect Architecture
# ----------------------------------------------------------

ARCH=$(uname -m)

case $ARCH in
    x86_64)
        SYS_ARCH="amd64"
        ;;
    aarch64|arm64)
        SYS_ARCH="arm64"
        ;;
    *)
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "Detected architecture: ${SYS_ARCH}"

# ----------------------------------------------------------
# Base Packages
# ----------------------------------------------------------

sudo apt update -y

sudo apt install -y \
    curl \
    wget \
    unzip \
    gnupg \
    lsb-release \
    ca-certificates \
    software-properties-common \
    apt-transport-https \
    jq

# ----------------------------------------------------------
# Docker Installation (Official)
# ----------------------------------------------------------

if ! command -v docker >/dev/null 2>&1; then

    echo "Installing Docker..."

    sudo install -m 0755 -d /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg

    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" \
      | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update -y

    sudo apt install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin

fi

sudo systemctl enable docker
sudo systemctl restart docker

# ----------------------------------------------------------
# Docker Permissions
# ----------------------------------------------------------

ACTUAL_USER=${SUDO_USER:-$USER}

sudo usermod -aG docker "$ACTUAL_USER"

# ----------------------------------------------------------
# Java 21 Runtime
# ----------------------------------------------------------

if ! java -version 2>&1 | grep -q "21"; then

    echo "Installing Java 21..."

    sudo apt install -y \
        fontconfig \
        openjdk-21-jre

fi

# ----------------------------------------------------------
# Jenkins Installation (Official 2026)
# ----------------------------------------------------------

if ! dpkg -l | grep -q jenkins; then

    echo "Installing Jenkins..."

    sudo mkdir -p /etc/apt/keyrings

    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \
      | sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null

    echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
      https://pkg.jenkins.io/debian-stable binary/" \
      | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    sudo apt update -y

    sudo apt install -y jenkins

fi

sudo systemctl daemon-reload

sudo systemctl enable jenkins
sudo systemctl restart jenkins

# ----------------------------------------------------------
# Add Jenkins To Docker Group
# ----------------------------------------------------------

if id "jenkins" &>/dev/null; then

    sudo usermod -aG docker jenkins

    sudo systemctl restart jenkins

fi

# ----------------------------------------------------------
# AWS CLI v2
# ----------------------------------------------------------

if ! command -v aws >/dev/null 2>&1; then

    echo "Installing AWS CLI..."

    curl -fsSL \
      "https://awscli.amazonaws.com/awscli-exe-linux-${SYS_ARCH}.zip" \
      -o awscliv2.zip

    unzip -oq awscliv2.zip

    sudo ./aws/install --update

    rm -rf aws awscliv2.zip

fi

# ----------------------------------------------------------
# kubectl Installation
# ----------------------------------------------------------

if ! command -v kubectl >/dev/null 2>&1; then

    echo "Installing kubectl..."

    KUBECTL_VERSION=$(curl -fsSL https://dl.k8s.io/release/stable.txt)

    curl -fsSLo kubectl \
      "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${SYS_ARCH}/kubectl"

    chmod +x kubectl

    sudo mv kubectl /usr/local/bin/

fi

# ----------------------------------------------------------
# eksctl Installation
# ----------------------------------------------------------

if ! command -v eksctl >/dev/null 2>&1; then

    echo "Installing eksctl..."

    EKSCTL_VERSION=$(curl -fsSL \
      https://api.github.com/repos/eksctl-io/eksctl/releases/latest \
      | jq -r '.tag_name')

    curl -fsSL \
      "https://github.com/eksctl-io/eksctl/releases/download/${EKSCTL_VERSION}/eksctl_Linux_${SYS_ARCH}.tar.gz" \
      -o eksctl.tar.gz

    tar -xzf eksctl.tar.gz

    sudo mv eksctl /usr/local/bin/

    chmod +x /usr/local/bin/eksctl

    rm -f eksctl.tar.gz

fi

# ----------------------------------------------------------
# Trivy Installation
# ----------------------------------------------------------

if ! command -v trivy >/dev/null 2>&1; then

    echo "Installing Trivy..."

    curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key \
      | sudo gpg --dearmor --yes -o /etc/apt/keyrings/trivy.gpg

    echo \
      "deb [signed-by=/etc/apt/keyrings/trivy.gpg] \
      https://aquasecurity.github.io/trivy-repo/deb generic main" \
      | sudo tee /etc/apt/sources.list.d/trivy.list > /dev/null

    sudo apt update -y

    sudo apt install -y trivy

fi

# ----------------------------------------------------------
# SonarQube Kernel Setting
# ----------------------------------------------------------

echo "Configuring vm.max_map_count..."

sudo sysctl -w vm.max_map_count=262144

if ! grep -q "vm.max_map_count=262144" /etc/sysctl.conf; then

    echo "vm.max_map_count=262144" \
      | sudo tee -a /etc/sysctl.conf

fi

# ----------------------------------------------------------
# SonarQube Deployment
# ----------------------------------------------------------

if ! sudo docker ps -a --format '{{.Names}}' | grep -q "^sonarqube$"; then

    echo "Starting SonarQube..."

    sudo docker volume create sonarqube_data
    sudo docker volume create sonarqube_extensions
    sudo docker volume create sonarqube_logs

    sudo docker run -d \
      --name sonarqube \
      --restart unless-stopped \
      -p 9000:9000 \
      -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
      -v sonarqube_data:/opt/sonarqube/data \
      -v sonarqube_extensions:/opt/sonarqube/extensions \
      -v sonarqube_logs:/opt/sonarqube/logs \
      sonarqube:lts-community

fi

# ----------------------------------------------------------
# Final Service Restart
# ----------------------------------------------------------

sudo systemctl restart docker
sudo systemctl restart jenkins

# ----------------------------------------------------------
# Installed Versions
# ----------------------------------------------------------

echo
echo "=========================================================="
echo " Installed Versions"
echo "=========================================================="

docker --version || true
java -version || true
aws --version || true
kubectl version --client || true
eksctl version || true
trivy --version || true
jenkins --version || true

# ----------------------------------------------------------
# URLs
# ----------------------------------------------------------

echo
echo "=========================================================="
echo " Access URLs"
echo "=========================================================="

echo "Jenkins   : http://<EC2-PUBLIC-IP>:8080"
echo "SonarQube : http://<EC2-PUBLIC-IP>:9000"

# ----------------------------------------------------------
# Jenkins Password
# ----------------------------------------------------------

echo
echo "=========================================================="
echo " Jenkins Initial Password"
echo "=========================================================="

sudo cat /var/lib/jenkins/secrets/initialAdminPassword || true

echo
echo "=========================================================="
echo " Setup Completed Successfully ✅"
echo "=========================================================="

echo "IMPORTANT:"
echo "1. Run: newgrp docker"
echo "2. Or reboot server after setup"
echo "3. Allow SG ports:"
echo "   - 8080 (Jenkins)"
echo "   - 9000 (SonarQube)"
echo "=========================================================="