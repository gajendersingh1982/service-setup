
variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "tf-galaxybadge-tfstate"
}

variable "table_name" {
  default = "terraform-up-and-running-locks"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default = {
    "Service"   = "gb"
    "Stage"     = "dev"
    "Owner"     = "gajender.s"
  }
}
