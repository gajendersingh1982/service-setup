#!/usr/bin/env bash

# It runs on host startup.
# Log everything we do.
set -x
exec >> /var/log/user-data-jenkins.log 2>&1

# wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
# sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update -y
sudo apt install default-jdk -y
sudo apt install jenkins -y --allow-unauthenticated
sudo apt-get install unzip -y

sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins

# Install Hashicorp Packer for building golden image
export PACKER_VER="1.5.6"
wget https://releases.hashicorp.com/packer/${PACKER_VER}/packer_${PACKER_VER}_linux_amd64.zip
unzip packer_${PACKER_VER}_linux_amd64.zip
sudo mv packer /usr/local/bin 

# Install Hashicorp Terraform for golden image
export TERRAFORM_VER="0.12.24"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip
unzip terraform_${TERRAFORM_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin 

# Displays Jenkins password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword