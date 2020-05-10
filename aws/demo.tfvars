variable "project" {
    type        = string
    description = "Project name"
    default     = "demo-terraform"
}

variable "environment" {
    type        = string
    description = <<EOT
        The name of enviroment for project.
        Default is name of tfvars file to apply.
        Typical values are [demo, dev, staging, prod].
    EOT
    default     = "demo"
}

variable "uid" {
    type        = string
    description = <<EOT
        Unique identifier for the build.
        Default will be timestamp in format:
        DD-MMM-YYYY-hh-mm-ss
    EOT
    default     = formatdate("DD-MMM-YYYY-hh-mm-ss", timestamp)
}

variable "aws_region" {
    type        = string
    description = "AWS region"
    default     = "us-east-1"
}

variable "vpc" {
    type        = map
    description = "CIDR for VPC and subnets"
    default     = {
        cidr        = "10.69.0.0/16"
        public_cidr = "10.69.10.0/24"
        private_cidr= "10.69.20.0/24"
    }
}

variable "enable_nat_gw" {
    type        = string
    description = "Enable NAT gateway deployment. Extra cost will be charged."
    default     = "false"
}

variable "dev_user" {
    type        = list
    description = "List of developers"
    default     = [
        "developer1",
        "developer2"
    ]
}

variable "devops_user" {
    type        = list
    description = "List of devops engineers"
    default     = [
        "devops1",
        "devops2"
    ]
}

variable "manager_user" {
    type        = list
    description = "List of managers"
    default     = [
        "manager1"
    ]
}

variable "app-vm" {
    type        = map
    description = "Configurations for Application VMs"
    default     = {
        count   = 1,
        type    = "t2.micro",
        ebs_size= 20
    }
}

variable "db-vm" {
    type        = map
    description = "Configurations for Database VMs"
    default     = {
        count   = 1,
        type    = "t2.micro",
        ebs_size= 20
    }
}

variable "lb-vm" {
    type        = map
    description = "Configurations for Load Balancing VMs"
    default     = {
        count   = 0,
        type    = "t2.micro",
        ebs_size= 20
    }
}
