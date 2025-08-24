#!/bin/bash
# Launch an instance with port 9000 open and at least t2.medium (4GB RAM recommended)

# Update system
sudo apt update -y && sudo apt upgrade -y

# Install required dependencies
sudo apt install -y wget unzip openjdk-17-jdk

# Go to /opt
cd /opt/

# Download and extract SonarQube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip
unzip sonarqube-8.9.6.50800.zip

# Create sonar user
sudo adduser --system --no-create-home --group --disabled-login sonar

# Set ownership and permissions
sudo chown -R sonar:sonar /opt/sonarqube-8.9.6.50800
sudo chmod -R 755 /opt/sonarqube-8.9.6.50800

# Switch to sonar user (manual step if running script non-interactively)
echo ">>> Now run manually as sonar user:"
echo "sudo -u sonar /opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh start"
echo "Default login -> user: admin , password: admin"
