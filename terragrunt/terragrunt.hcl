# Keep your provider configuration DRY
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "ap-southeast-1"
}
EOF
}

# Keep your backend configuration DRY
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "demo-minhluantran017-com"
    key = "terraform-states/terragrunt-test/${path_relative_to_include()}/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

# Keep your Terraform CLI arguments DRY
terraform {
  extra_arguments "common_vars" {
    commands = ["plan", "apply", "destroy"]

    arguments = [
      "-var-file=../vars/common.tfvars",
      "-var project=terragrunt",
      "-var environment=test"
    ]
  }
}

# Keep common configuration DRY
generate "wrapper" {
  path = "wrapper.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
locals {
    common_tags = {
        project     = var.project
        environment = var.environment
    }
}
variable "project" {
    type        = string
    description = "Project name"
}

variable "environment" {
    type        = string
}
variable "vpc1" {
    type        = map
    description = "CIDR for VPC and subnets"
}
variable "vpc2" {
    type        = map
    description = "CIDR for VPC and subnets"
}
EOF
}
