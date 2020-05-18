prefix = "tf"
region_name = "virginia"
service = "gb"
stage = "stg"
vpc_region = "us-east-1" 

tags = {
    "Service" = "gb"
    "Stage"     = "stg"
}

# Instance Details
instance_type_admin = "t3.micro"
instance_type_openapi = "t3.micro"
rds_instance_type = "db.t2.small"
key_name = "galaxybadge_dev"
was_ami_name = "tf-virginia-stg-gb-was*"
domain_name ="*.galaxy.store"

# Firewall variables
restrictedIP = ["162.246.216.28/32", "223.235.161.164/32", "103.81.106.248/30"]
#                   my IP,                  SEA IP,             SRID IP
  
publicIP = "122.177.159.124/32"
network_backend_state = "badge/stg/us-east-1/network/terraform.tfstate"