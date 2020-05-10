terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-galaxy"
    key            = "account-name/dev/service-jenkins-batch/terraform.tfstate"
    region         = "us-east-1"
    
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "devops-terraform-state-galaxy"
    key    = "account-name/dev/infra/terraform.tfstate"
    region = "us-east-1"
  }
}
