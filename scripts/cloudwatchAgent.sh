#!/usr/bin/env bash

curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
sudo python3 ./awslogs-agent-setup.py --region us-east-1 --non-interactive
sudo rm /var/awslogs/etc/awslogs.conf
sudo echo "
[general]
# Path to the CloudWatch Logs agent's state file. The agent uses this file to maintain
# client side state across its executions.
state_file = /var/awslogs/state/agent-state
  
[/var/log/syslog]
buffer_duration = 5000
initial_position = start_of_file
datetime_format = %b %d %H:%M:%S
log_group_name = /var/log/syslog
file = /var/log/syslog
log_stream_name = {instance_id}
">/var/awslogs/etc/awslogs.conf

