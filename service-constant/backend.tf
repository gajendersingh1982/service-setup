terraform {
  backend "s3" {
    bucket         = "tf-service-tfstate"
    region         = "us-east-1"    
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "tf-service-tfstate"
    key    = var.network_backend_state
    region = "us-east-1"
  }
}
