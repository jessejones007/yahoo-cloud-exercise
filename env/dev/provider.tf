provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-file-1234"
    key            = "statefile/terraform.tfstate"
    region         = "eu-north-1"
  }
}
