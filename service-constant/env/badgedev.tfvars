prefix = "tf"
region_name = "virginia"
service = "gb"
stage = "dev"
vpc_region = "us-east-1" 

tags = {
    "Service" = "gb"
    "Stage"     = "dev"
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
domain_name ="*.samsungops.com"
# domain_name ="*.galaxy.store"

# Firewall variables
restrictedIP = ["162.246.216.28/32", "223.235.161.164/32", "103.81.106.248/30"]
#                   my IP,                  SEA IP,             SRID IP
  
publicIP = "122.177.159.124/32"

# Backends
network_backend_state = "badge/dev/us-east-1/network/terraform.tfstate"