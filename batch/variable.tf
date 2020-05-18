variable "restrictedIP" {
  description = "Restricted IP"
}

variable "publicIP" {
  description = "my IP"
}

variable "prefix" {
}

variable "region_name" {
}

variable "service" {
}

variable "stage" {
}

 variable "vpc_region" {
  description = "AWS VPC Region"
 }

# variable "azs" {
#   description = "List of azs"
#   default = ["us-east-1a", "us-east-1b"]
# }

variable "tags" {
  description = "A mapping of tags to assign to the resource"
}


# Instance Variables
variable "instance_type_batch"{
  description = "Instance Type"
}

variable "key_name"{
  description = "Instance Type"
}

variable "batch_ami_name"{
  description = "Instance Type"
}

variable "network_backend_state"{
  description = "Netwrok backend path"
}
