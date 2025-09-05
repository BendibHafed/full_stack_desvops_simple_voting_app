terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-he1"
    key            = "voting-app/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}