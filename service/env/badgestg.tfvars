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
key_name = "galaxybadge_dev"
# was_ami_name = "tf-virginia-stg-gb-was*"

# Firewall variables
restrictedIP = ["223.235.161.164/32", "103.81.106.248/30"]
#                      SEA IP,             SRID IP

# Backends
network_backend_state = "badge/stg/us-east-1/network/terraform.tfstate"
service_constant_backend_state = "badge/stg/us-east-1/service-const/terraform.tfstate"
service_backend_state = "badge/stg/us-east-1/service/terraform.tfstate"