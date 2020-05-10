terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-gb"
    key            = "dev/batch/terraform.tfstate"
    region         = "us-east-1"
    
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "devops-terraform-state-gb"
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}
