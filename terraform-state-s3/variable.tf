
variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "devops-terraform-state-gb"
}


variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default = {
    "Service"   = "gb"
    "Stage"     = "dev"
    "Owner"     = "gajender.s"
  }
}
