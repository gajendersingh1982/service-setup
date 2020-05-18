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
instance_type_batch = "t3.medium"
key_name = "galaxybadge_dev"
batch_ami_name = "tf-virginia-dev-gb-batch-1589707255"

# Firewall variables
restrictedIP = ["162.246.216.28/32", "223.235.161.164/32", "103.81.106.248/30"]
#                   my IP,                  SEA IP,             SRID IP
                    
publicIP = "171.48.33.128/32"
network_backend_state = "badge/dev/us-east-1/network/terraform.tfstate"
