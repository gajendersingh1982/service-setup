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

# RDS Variables
variable "rds_instance_type"{
  description = "DB Instance Class"
}

variable "domain_name"{
  description = "SSL Domain to be used for ALB(443-ACM)"
}

# Other variables
variable "db_password"{
  description = "Enter Password to Set for Database"
}

variable "db_snapshot"{
  description = "Enter Password to Set for Database"
}

variable "backup_retention_period" {
  description = "Number of days of backupto retain"
  default = "7"
}

variable "multi_az" {
  description = "Number of days of backupto retain"
}

variable "publicly_accessible" {
  description = "Needs to be open to public"
}

variable "allocated_storage" {
  description = "Min storage for DB"
}

variable "max_allocated_storage" {
  description = "Enable autoscalling with max storage"
}
variable "db_name" {

}

variable "db_username" {

}