provider "aws" {
    region = var.aws_region
}

terraform {
  /* Configure S3 backend for AWS to store Terraform state.*/
  backend "s3" {
    bucket = "devops-minhluantran017-com"
    key    = "${var.project}/${var.environment}/terraform-state/${var.uid}"
    region = var.aws_region
  }
}