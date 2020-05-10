variable "kvm_ip" {
    type        = string
    description = "KVM host IP address"
    default     = "10.250.200.220"
}

variable "kvm_user" {
    type        = string
    description = "KVM host username"
    default     = "root"
}

variable "base_image_name" {
    type        = string
    description = "Base image name"
    default     = "CentOS-7-x86_64-GenericCloud-1907.qcow2"
}

variable "base_image_url" {
    type        = string
    description = "Base image download URL"
    default     = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
}

variable "demo_terraform_vm" {
    type        = map
    description = "Configurations for demo-terraform VMs"
    default     = {
        count   = 2,
        vcpu    = 2,
        ram     = 4096,
        disk    = 50000
    }
}