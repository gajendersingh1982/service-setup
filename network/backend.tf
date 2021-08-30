terraform {
  backend "s3" {
    bucket         = "tf-service-tfstate"
    region         = "us-east-1"    
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
