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
    type        = bool
    description = "Enable NAT gateway deployment. Extra cost will be charged."
    default     = false
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

variable "app_vm" {
    type        = object{count = number, type = string, ebs_size = number}
    description = "Configurations for Application VMs"
    default     = {
        count   = 1,
        type    = "t2.micro",
        ebs_size= 20
    }
}

variable "db_vm" {
    type        = object{count = number, type = string, ebs_size = number}
    description = "Configurations for Database VMs"
    default     = {
        count   = 1,
        type    = "t2.micro",
        ebs_size= 20
    }
}

variable "lb_vm" {
    type        = object{count = number, type = string, ebs_size = number}
    description = "Configurations for Load Balancing VMs"
    default     = {
        count   = 0,
        type    = "t2.micro",
        ebs_size= 20
    }
}

variable "create_eks" {
    type        = bool
    description = "Optionally create EKS cluster"
    default     = false
}