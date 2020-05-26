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
instance_type_batch = "t3.medium"
key_name = "galaxybadge_dev"
batch_ami_name = "tf-virginia-stg-gb-batch*"

# Firewall variables
restrictedIP = ["223.235.161.164/32", "103.81.106.248/30"]
#                      SEA IP,             SRID IP

network_backend_state = "badge/stg/us-east-1/network/terraform.tfstate"
