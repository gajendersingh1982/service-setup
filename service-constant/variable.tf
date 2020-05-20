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

variable "access" {
  default = "access_key"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
}

variable "network_backend_state"{
  description = "Netwrok backend path"
}

variable "service_constant_backend_state"{
  description = "service-constant backend path"
}

variable "service_backend_state"{
  description = "service backend path"
}

# EC2 Variables
variable "instance_type_admin"{
  description = "Instance Type"
}

variable "instance_type_openapi"{
  description = "Instance Type"
}

variable "rds_instance_type"{
  description = "DB Instance Type"
}

variable "was_ami_name"{
  description = "DB Instance Type"
}

variable "key_name"{
  description = "Instance Type"
}

variable "domain_name"{
  description = "Instance Type"
}

# Other variables
variable "db_password"{
  description = "Instance Type"
  default = "password"
}
