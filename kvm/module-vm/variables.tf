variable "libvirt_pool" {
    type        = string
    description = "KVM libvirt pool name to create VMs (domain) in"
    default     = "default"
}

variable "create_pool" {
    type        = bool
    description = "Create libvirt pool?"
    default     = false
}

variable "base_image_url" {
    type        = string
    description = "URL of the base image file (.img)"
    default     = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
}

variable "vm_name" {
    type        = string
    description = "Name prefix of your VMs"
}

variable "vm_count" {
    type        = number
    description = "Number of VMs to create"
    default     = 1
}

variable "vm_vcpu" {
    type        = number
    description = "Number of vCPU for each VM"
    default     = 1
}

variable "vm_memory" {
    type        = number
    description = "Amount of memory (in MegaByte) for each VM"
    default     = 1024
}

variable "vm_disk" {
    type        = number
    description = "Size of disk (in Byte) for each VM"
    default     = 20000000000
}

variable "ip_addresses" {
    type        = list(string)
    description = "List of string of IP addresses for your VMs"
    default     = ["192.168.1.10"]
}

variable "gw_address" {
    type        = string
    description = "Gateway IP address of your network"
    default     = "192.168.1.1"
}

variable "dns_address" {
    type        = string
    description = "DNS server for your network"
    default     = "8.8.8.8"
}

variable "ssh_public_key" {
    type = string
    description = "SSH public key to inject into VM for SSH access"
}