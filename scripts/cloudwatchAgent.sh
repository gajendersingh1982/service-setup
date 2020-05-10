# Install packages
sudo yum install -y perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA.x86_64

# Download monitoring scripts
curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O

# Install monitoring scripts
unzip CloudWatchMonitoringScripts-1.2.2.zip && \
rm CloudWatchMonitoringScripts-1.2.2.zip && \
cd aws-scripts-mon



# Perform a simple test without pushing to CloudWatch
./mon-put-instance-data.pl --mem-util --verify --verbose

# Push to CloudWatch manually
./mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --mem-used --mem-avail

# Scheduling metrics report to CloudWatch
crontab -e 
*/1 * * * * ~/aws-scripts-mon/mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --mem-used --mem-avail --disk-space-util --disk-path=/ --from-cron

# To Get utilization statistics on the instance terminal
./mon-get-instance-stats.pl --recent-hours=12
