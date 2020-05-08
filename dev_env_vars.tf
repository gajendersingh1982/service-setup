variable "instance_type_batch"{
  description = "Instance Type"
  default = "t3.micro"
}

variable "admin_count"{
  description = "Count"
  default = "2"
}

variable "instance_type_admin"{
  description = "Instance Type"
  default = "t3.micro"
}

variable "instance_type_openapi"{
  description = "Instance Type"
  default = "t3.micro"
}

variable "rds_instance_type"{
  description = "DB Instance Type"
  default = "db.t2.small"
}

variable "key_name"{
  description = "Instance Type"
  default = "gaj_test"
}