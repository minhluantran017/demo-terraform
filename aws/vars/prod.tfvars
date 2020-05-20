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
    default     = "prod"
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
    default     = "us-west-1"
}

variable "vpc" {
    type        = map
    description = "CIDR for VPC and subnets"
    default     = {
        cidr        = "10.79.0.0/16"
        public_cidr = "10.79.10.0/24"
        private_cidr= "10.79.20.0/24"
    }
}
variable "enable_nat_gw" {
    type        = string
    description = "Enable NAT gateway deployment. Extra cost will be charged."
    default     = "true"
}

variable "dev_user" {
    type        = list
    description = "List of developers"
    default     = [
        "developer1",
        "developer2",
        "developer3"
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
        "manager1",
        "prime1"
    ]
}

variable "app-vm" {
    type        = map
    description = "Configurations for Application VMs"
    default     = {
        count   = 2,
        type    = "t2.xlarge",
        ebs_size= 100
    }
}

variable "db-vm" {
    type        = map
    description = "Configurations for Database VMs"
    default     = {
        count   = 3,
        type    = "t2.medium",
        ebs_size= 200
    }
}

variable "lb-vm" {
    type        = map
    description = "Configurations for Load Balancing VMs"
    default     = {
        count   = 1,
        type    = "t2.large",
        ebs_size= 50
    }
}
