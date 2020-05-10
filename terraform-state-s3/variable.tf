
variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "devops-terraform-state-galaxy"
}


variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default = {
    "Service" = "galaxy-badge"
    "Stage"     = "dev"
  }
}
