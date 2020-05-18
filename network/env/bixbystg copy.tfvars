# VPC Variables
vpc_cidr = "10.21.0.0/20"
public_cidr = ["10.21.1.0/24", "10.21.2.0/24"]
private_cidr = ["10.21.3.0/24", "10.21.4.0/24"]
vpc_region = "us-east-1" 
azs = ["us-east-1a", "us-east-1b"]

# Common Variables
prefix = "tf"
region_name = "virginia"
service = "bixby"
stage = "stg"
tags = {
    "Service" = "bixby"
    "Stage"     = "stg"
}