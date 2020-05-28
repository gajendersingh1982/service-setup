variable "restrictedIP" {
  description = "Restricted IP"
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
  description = "Batch Instance Class"
}

variable "instance_type_mail_train"{
  description = "Mail Train Instance Class"
}

variable "instance_type_gateway"{
  description = "Mail Train Instance Class"
}

variable "batch_count"{
  description = "Batch Instance Class"
}

variable "mail_train_count"{
  description = "Mail Train Instance Class"
}

variable "gateway_count"{
  description = "Mail Train Instance Class"
}

variable "key_name"{
  description = "Key for login into EC2"
}

variable "batch_ami_name"{
  description = "Batch AMI Name"
}

variable "mail_train_ami_name"{
  description = "Mail Train AMI Name"
}

variable "network_backend_state"{
  description = "Netwrok backend path"
}
