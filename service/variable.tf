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
  description = "Instance Type for Admin EC2"
}

variable "instance_type_openapi"{
  description = "Instance Type for OpenAPI ASG"
}

variable "was_ami_name"{
  description = "DB Instance Type"
}

variable "key_name"{
  description = "Instance Type"
}

variable "env_var"{
  description = "Instance Type"
  default = "test"
}