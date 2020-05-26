# VPC Variables
vpc_cidr = "10.10.0.0/20"
public_cidr = ["10.10.1.0/24", "10.10.2.0/24"]
private_cidr = ["10.10.3.0/24", "10.10.4.0/24"]
vpc_region = "us-east-1" 
azs = ["us-east-1a", "us-east-1b"]

# Common Variables
prefix = "tf"
region_name = "virginia"
service = "gb"
stage = "dev"
tags = {
    "Service" = "gb"
    "Stage"     = "dev"
}

# Backend 
network_backend_state = "badge/dev/us-east-1/network/terraform.tfstate"