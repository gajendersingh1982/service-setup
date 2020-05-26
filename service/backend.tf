terraform {
  backend "s3" {
    bucket         = "tf-galaxybadge-tfstate"
    region         = "us-east-1"    
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "tf-galaxybadge-tfstate"
    key    = var.network_backend_state
    region = "us-east-1"
  }
}

data "terraform_remote_state" "service-const" {
  backend = "s3"
  config = {
    bucket = "tf-galaxybadge-tfstate"
    key    = var.service_constant_backend_state
    region = "us-east-1"
  }
}
