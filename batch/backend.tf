terraform {
  backend "s3" {
    bucket         = "tf-galaxybadge-tfstate"
    key            = "dev/batch/terraform.tfstate"
    region         = "us-east-1"
    
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "tf-galaxybadge-tfstate"
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}
