#!/bin/bash
set -e

# Update system
apt update -y

# Install Java (required)
apt install -y openjdk-17-jdk curl gnupg

# Create keyrings directory
mkdir -p /usr/share/keyrings

# Add Jenkins GPG key (CORRECT way)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | gpg --dearmor -o /usr/share/keyrings/jenkins-keyring.asc

# Add Jenkins repository
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  > /etc/apt/sources.list.d/jenkins.list

# Update and install Jenkins
apt update -y
apt install -y jenkins

# Start & enable Jenkins
systemctl enable jenkins
systemctl start jenkins
