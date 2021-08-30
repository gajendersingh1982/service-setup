
terraform {
  backend "s3" {
    bucket         = "tf-service-tfstate"
    key            = "backend/s3/terraform.tfstate"
    region         = "us-east-1"
    
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
