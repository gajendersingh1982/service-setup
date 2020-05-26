# VPC Variables
vpc_cidr = "10.11.0.0/20"
public_cidr = ["10.11.1.0/24", "10.11.2.0/24"]
private_cidr = ["10.11.3.0/24", "10.11.4.0/24"]
vpc_region = "us-east-1" 
azs = ["us-east-1a", "us-east-1b"]

# Common Variables
prefix = "tf"
region_name = "virginia"
service = "gb"
stage = "stg"
tags = {
    "Service" = "gb"
    "Stage"     = "stg"
}

# Backend 
network_backend_state = "badge/stg/us-east-1/network/terraform.tfstate"