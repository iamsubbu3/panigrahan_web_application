#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

echo "=================================================================="
echo " DevSecOps Setup Script (Ubuntu 24.04 LTS - 2026)"
echo " Docker | Jenkins | SonarQube | Trivy | AWS CLI | kubectl | eksctl"
echo "=================================================================="

# ----------------------------------------------------------
# VERIFY UBUNTU
# ----------------------------------------------------------

if ! command -v apt >/dev/null 2>&1; then
    echo "❌ Ubuntu/Debian system required"
    exit 1
fi

# ----------------------------------------------------------
# ARCHITECTURE DETECTION
# ----------------------------------------------------------

ARCH=$(uname -m)

case $ARCH in
    x86_64)
        AWS_ARCH="x86_64"
        K8S_ARCH="amd64"
        ;;
    aarch64|arm64)
        AWS_ARCH="aarch64"
        K8S_ARCH="arm64"
        ;;
    *)
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "Detected AWS CLI Architecture : ${AWS_ARCH}"
echo "Detected Kubernetes Architecture : ${K8S_ARCH}"

# ----------------------------------------------------------
# SYSTEM UPDATE
# ----------------------------------------------------------

sudo apt update -y

# ----------------------------------------------------------
# INSTALL BASE PACKAGES
# ----------------------------------------------------------

sudo apt install -y \
    curl \
    wget \
    unzip \
    gnupg \
    lsb-release \
    ca-certificates \
    software-properties-common \
    apt-transport-https \
    jq \
    git

# ----------------------------------------------------------
# INSTALL JAVA 21 FIRST
# ----------------------------------------------------------

if ! java -version 2>/dev/null | grep -q "21"; then

    echo "Installing Java 21..."

    sudo apt install -y fontconfig

    sudo apt install -y openjdk-21-jre

fi

# ----------------------------------------------------------
# VERIFY JAVA
# ----------------------------------------------------------

echo "Verifying Java Installation..."

java -version

# ----------------------------------------------------------
# REFRESH JAVA CERTIFICATES
# ----------------------------------------------------------

sudo update-ca-certificates -f || true

# ----------------------------------------------------------
# INSTALL DOCKER
# ----------------------------------------------------------

if ! command -v docker >/dev/null 2>&1; then

    echo "Installing Docker..."

    sudo install -m 0755 -d /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

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
# DOCKER PERMISSIONS
# ----------------------------------------------------------

CURRENT_USER=${SUDO_USER:-ubuntu}

sudo usermod -aG docker ${CURRENT_USER}

# ----------------------------------------------------------
# INSTALL JENKINS
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

sudo systemctl restart jenkins || true

# ----------------------------------------------------------
# ADD JENKINS TO DOCKER GROUP
# ----------------------------------------------------------

if id "jenkins" &>/dev/null; then

    sudo usermod -aG docker jenkins

    sudo systemctl restart jenkins || true

fi

# ----------------------------------------------------------
# INSTALL AWS CLI v2
# ----------------------------------------------------------

if ! command -v aws >/dev/null 2>&1; then

    echo "Installing AWS CLI..."

    curl -fsSL \
      "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" \
      -o awscliv2.zip

    unzip -o awscliv2.zip

    sudo ./aws/install \
      --bin-dir /usr/local/bin \
      --install-dir /usr/local/aws-cli \
      --update

    rm -rf aws awscliv2.zip

fi

# ----------------------------------------------------------
# VERIFY AWS CLI
# ----------------------------------------------------------

aws --version

# ----------------------------------------------------------
# INSTALL KUBECTL
# ----------------------------------------------------------

if ! command -v kubectl >/dev/null 2>&1; then

    echo "Installing kubectl..."

    KUBECTL_VERSION=$(curl -fsSL https://dl.k8s.io/release/stable.txt)

    curl -fsSLO \
      "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${K8S_ARCH}/kubectl"

    chmod +x kubectl

    sudo mv kubectl /usr/local/bin/

fi

# ----------------------------------------------------------
# VERIFY KUBECTL
# ----------------------------------------------------------

kubectl version --client

# ----------------------------------------------------------
# INSTALL EKSCTL
# ----------------------------------------------------------

if ! command -v eksctl >/dev/null 2>&1; then

    echo "Installing eksctl..."

    EKSCTL_VERSION=$(curl -fsSL \
      https://api.github.com/repos/eksctl-io/eksctl/releases/latest \
      | jq -r '.tag_name')

    curl -fsSL \
      "https://github.com/eksctl-io/eksctl/releases/download/${EKSCTL_VERSION}/eksctl_Linux_${K8S_ARCH}.tar.gz" \
      -o eksctl.tar.gz

    tar -xzf eksctl.tar.gz

    sudo mv eksctl /usr/local/bin/

    sudo chmod +x /usr/local/bin/eksctl

    rm -f eksctl.tar.gz

fi

# ----------------------------------------------------------
# VERIFY EKSCTL
# ----------------------------------------------------------

eksctl version

# ----------------------------------------------------------
# INSTALL TRIVY
# ----------------------------------------------------------

if ! command -v trivy >/dev/null 2>&1; then

    echo "Installing Trivy..."

    sudo mkdir -p /etc/apt/keyrings

    curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key \
      | sudo gpg --dearmor -o /etc/apt/keyrings/trivy.gpg

    echo \
      "deb [signed-by=/etc/apt/keyrings/trivy.gpg] \
      https://aquasecurity.github.io/trivy-repo/deb generic main" \
      | sudo tee /etc/apt/sources.list.d/trivy.list > /dev/null

    sudo apt update -y

    sudo apt install -y trivy

fi

# ----------------------------------------------------------
# VERIFY TRIVY
# ----------------------------------------------------------

trivy --version

# ----------------------------------------------------------
# SONARQUBE KERNEL SETTINGS
# ----------------------------------------------------------

echo "Configuring kernel settings for SonarQube..."

sudo sysctl -w vm.max_map_count=524288

sudo sysctl -w fs.file-max=131072

if ! grep -q "vm.max_map_count=524288" /etc/sysctl.conf; then
    echo "vm.max_map_count=524288" \
      | sudo tee -a /etc/sysctl.conf
fi

if ! grep -q "fs.file-max=131072" /etc/sysctl.conf; then
    echo "fs.file-max=131072" \
      | sudo tee -a /etc/sysctl.conf
fi

# ----------------------------------------------------------
# INSTALL SONARQUBE
# ----------------------------------------------------------

if ! sudo docker ps -a --format '{{.Names}}' | grep -q "^sonarqube$"; then

    echo "Installing SonarQube..."

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
# FINAL SERVICE RESTART
# ----------------------------------------------------------

sudo systemctl restart docker

sudo systemctl restart jenkins || true

# ----------------------------------------------------------
# INSTALLED VERSIONS
# ----------------------------------------------------------

echo
echo "=========================================================="
echo " INSTALLED TOOL VERSIONS"
echo "=========================================================="

docker --version || true
java -version || true
aws --version || true
kubectl version --client || true
eksctl version || true
trivy --version || true
jenkins --version || true

# ----------------------------------------------------------
# ACCESS URLS
# ----------------------------------------------------------

echo
echo "=========================================================="
echo " ACCESS URLS"
echo "=========================================================="

echo "Jenkins   : http://<EC2-PUBLIC-IP>:8080"

echo "SonarQube : http://<EC2-PUBLIC-IP>:9000"

# ----------------------------------------------------------
# JENKINS INITIAL PASSWORD
# ----------------------------------------------------------

echo
echo "=========================================================="
echo " JENKINS INITIAL ADMIN PASSWORD"
echo "=========================================================="

sudo cat /var/lib/jenkins/secrets/initialAdminPassword || true

echo
echo "=========================================================="
echo " SETUP COMPLETED SUCCESSFULLY ✅"
echo "=========================================================="

echo "IMPORTANT:"
echo "1. Reboot server after setup"
echo "2. Open Security Group Ports:"
echo "   - 8080 (Jenkins)"
echo "   - 9000 (SonarQube)"
echo "=========================================================="