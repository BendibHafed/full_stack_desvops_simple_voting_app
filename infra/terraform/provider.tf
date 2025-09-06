provider "aws" {
  region     = var.aws_region
  #profile = var.aws_profile # use it for local dev.
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
