provider "aws" {
    region = var.aws_region
}

terraform {
    # Configure S3 backend for AWS to store Terraform state.
    backend "s3" {
        bucket = "devops-minhluantran017-com"
        key    = "${var.project}/${var.environment}/terraform-state/${var.uid}"
        region = var.aws_region
    }
}

locals {
    # Common tags to be assigned to all resources
    common_tags = {
        project     = var.project
        environment = var.environment
    }
}