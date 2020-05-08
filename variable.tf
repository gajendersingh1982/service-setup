variable "myip" {
  description = "my IP"
  default = "122.177.9.54/32"
}

variable "publicIP" {
  description = "my IP"
  default = "122.177.9.54/32"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  default = "10.0.0.0/20"
}

variable "public_cidr" {
  description = "list of public subnets to be created"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidr" {
  description = "list of private subnets to be created"
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "prefix" {
  default = "tf"
}

variable "region_name" {
  default = "virginia"
}

variable "service" {
  default = "gb"
}

variable "stage" {
  default = "dev"
}

 variable "vpc_region" {
  description = "AWS VPC Region"
  default = "us-east-1"
 }
variable "azs" {
  description = "List of azs"
  default = ["us-east-1a", "us-east-1b"]
}
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default = {
    "Service"   = "gb"
    "Stage"     = "dev"
    "Creator"   = "gajender.s"
  }
}
