provider "aws" {
    region = "ap-southeast-1"
}

data "aws_availability_zones" "available" {}

terraform {
    # Configure S3 backend for AWS to store Terraform state.
    backend "s3" {
        bucket = "demo-minhluantran017-com"
        key    = "terraform-states/demo-terraform/terraform.tfstate"
        region = "ap-southeast-1"
    }
    required_version = ">= 0.12"
}

locals {
    # Common tags to be assigned to all resources
    common_tags = {
        project     = "demo-terraform"
        environment = "demo"
    }
    base_name = "demo-terraform-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
    length  = 8
    special = false
}