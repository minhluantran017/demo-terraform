provider "aws" {
    region = var.aws_region
}

data "aws_availability_zones" "available" {}

terraform {
    # Configure S3 backend for AWS to store Terraform state.
    backend "s3" {
        bucket = "${var.s3_bucket}"
        key    = "${var.project}/${var.environment}/terraform-state/${var.uid}"
        region = var.aws_region
    }
    required_version = ">= 0.12"
}

locals {
    # Common tags to be assigned to all resources
    common_tags = {
        project     = var.project
        environment = var.environment
    }
    cluster_name = "training-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
    length  = 8
    special = false
}