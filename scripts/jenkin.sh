#!/usr/bin/env bash

# It runs on host startup.
# Log everything we do.
set -x
exec >> /var/log/user-data-jenkins.log 2>&1

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update -y
sudo apt install default-jdk -y
sudo apt install jenkins -y --allow-unauthenticated

sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins

# sudo ufw allow 8080
# sudo ufw status

# Displays Jenkins password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword