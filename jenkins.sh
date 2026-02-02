#!/bin/bash
set -e

# Update system
apt update -y

# Install Java 17 (required by Jenkins)
apt install -y openjdk-17-jdk

# Add Jenkins key (NEW method)
mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repo
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ \
| tee /etc/apt/sources.list.d/jenkins.list

# Update again
apt update -y

# Install Jenkins
apt install -y jenkins

# Start & enable Jenkins
systemctl enable jenkins
systemctl start jenkins

