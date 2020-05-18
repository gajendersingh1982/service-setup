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
instance_type_batch = "t3.medium"
key_name = "bixby_dev"
batch_ami_name = "tf-virginia-stg-bixby-batch*"

# Firewall variables
restrictedIP = ["162.246.216.28/32", "223.235.161.164/32", "103.81.106.248/30"]
#                   my IP,                  SEA IP,             SRID IP
  
publicIP = "122.177.159.124/32"
network_backend_state = "bixby/stg/us-east-1/network/terraform.tfstate"
