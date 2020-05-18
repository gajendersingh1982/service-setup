# VPC Variables
vpc_cidr = "10.20.0.0/20"
public_cidr = ["10.20.1.0/24", "10.20.2.0/24"]
private_cidr = ["10.20.3.0/24", "10.20.4.0/24"]
vpc_region = "us-east-1" 
azs = ["us-east-1a", "us-east-1b"]

# Common Variables
prefix = "tf"
region_name = "virginia"
service = "bixby"
stage = "dev"
tags = {
    "Service" = "bixby"
    "Stage"     = "dev"
}