#!/bin/bash
set -e

echo "=== Cleaning old Jenkins config (if any) ==="
rm -f /etc/apt/sources.list.d/jenkins.list
rm -f /usr/share/keyrings/jenkins-keyring.asc
apt update -y || true

echo "=== Installing dependencies ==="
apt install -y openjdk-17-jdk curl gnupg

echo "=== Adding Jenkins GPG key (correct way) ==="
mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | gpg --dearmor -o /usr/share/keyrings/jenkins-keyring.asc

echo "=== Adding Jenkins repository ==="
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  > /etc/apt/sources.list.d/jenkins.list

echo "=== Updating apt & installing Jenkins ==="
apt update -y
apt install -y jenkins

echo "=== Enabling Jenkins service ==="
systemctl enable jenkins
systemctl start jenkins

echo "=== Jenkins installation completed successfully ==="
