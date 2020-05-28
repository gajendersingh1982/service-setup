prefix = "tf"
region_name = "virginia"
service = "bixby"
stage = "stg"
vpc_region = "us-east-1" 

tags = {
    "Service" = "bixby"
    "Stage"     = "stg"
}

# Instance Details
rds_instance_type = "db.t3.small"
db_snapshot = "abc"
db_name              = "demodb"
db_username          = "user"

multi_az = "false"
publicly_accessible = "false"
allocated_storage = "50"
max_allocated_storage = "100"

# SSL certificate
domain_name ="*.bixby.store"

# Firewall variables
restrictedIP            = ["223.235.161.164/32", "103.81.106.248/30"]
#                                   SEA IP,             SRID IP
  
publicIP = "0.0.0.0/0"
network_backend_state = "bixby/stg/us-east-1/network/terraform.tfstate"