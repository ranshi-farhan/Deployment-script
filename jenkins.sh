#!/bin/bash
set -e

echo "Updating system..."
apt-get update -y

echo "Installing Java (Jenkins requirement)..."
apt-get install -y openjdk-17-jdk

echo "Adding Jenkins GPG key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "Adding Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package index..."
apt-get update -y

echo "Installing Jenkins..."
apt-get install -y jenkins

echo "Enabling and starting Jenkins..."
systemctl enable jenkins
systemctl start jenkins

echo "Jenkins installed successfully!"
echo "Initial Admin Password:"
cat /var/lib/jenkins/secrets/initialAdminPassword
