#!/usr/bin/env bash

# It runs on host startup.
# Log everything we do.
set -x
exec >> /var/log/user-data-tomcat.log 2>&1

sudo apt-get update -y
sudo apt install default-jdk -y

sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

cd /tmp
sudo wget https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.54/bin/apache-tomcat-8.5.54.tar.gz
#curl -O http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz

sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

cd /opt/tomcat

# Give the tomcat group ownership over the entire installation directory:
sudo chgrp -R tomcat /opt/tomcat

sudo chmod -R g+r conf
sudo chmod g+x conf

sudo chown -R tomcat webapps/ work/ temp/ logs/

sudo update-java-alternatives -l

# Download AWS CLI
sudo apt-get install awscli -y

# #Create the tomcat service file.
# sudo touch /etc/systemd/system/tomcat.service

# FILE="/etc/systemd/system/tomcat.service"

# # edit tomcat service config file for the PDB server
# sudo /bin/cat <<EOM >$FILE
# [Unit]
# Description=Apache Tomcat Web Application Container
# After=network.target

# [Service]
# Type=forking

# Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre
# Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
# Environment=CATALINA_HOME=/opt/tomcat
# Environment=CATALINA_BASE=/opt/tomcat
# Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
# Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

# ExecStart=/opt/tomcat/bin/startup.sh
# ExecStop=/opt/tomcat/bin/shutdown.sh

# User=tomcat
# Group=tomcat
# UMask=0007
# RestartSec=10
# Restart=always

# [Install]
# WantedBy=multi-user.target
# EOM


####################################################################
# Copy Release binary in this Instance when launching and explode *.war
####################################################################
# sudo rm -rf /opt/tomcat/webapps/*                 # Remove other webApps
# aws s3 mv s3://tf-virginia-dev-galaxybadge-release/ROOT.war /opt/tomcat/webapps               # Install Latest package

# sudo systemctl daemon-reload
# sudo systemctl start tomcat
# sudo systemctl status tomcat
# sudo systemctl enable tomcat

# Allow firewall
#sudo ufw allow 8080

# Update tomcat-user using sed
# Update context.xml using sed

# # Set alll enviornment variables here

# # Make deploy dir and give tomcat permission on it
# sudo mkdir /data/deploy
# sudo chgrp -R tomcat /data/deploy

# wget https://s3.us-east-1.amazonaws.com/amazoncloudwatch-agent-us-east-1/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
# sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
