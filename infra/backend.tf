terraform {
  backend "s3" {
    bucket         = "tf-galaxybadge-tfstate"
    key            = "dev/network/terraform.tfstate"
    region         = "us-east-1"
    
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
