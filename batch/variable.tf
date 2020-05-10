variable "myip" {
  description = "my IP"
  default = "122.177.159.124/32"
}

variable "publicIP" {
  description = "my IP"
  default = "122.177.159.124/32"
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

# variable "azs" {
#   description = "List of azs"
#   default = ["us-east-1a", "us-east-1b"]
# }

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default = {
    "Service" = "gb"
    "Stage"     = "dev"
  }
}
