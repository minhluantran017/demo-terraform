variable "build_number" {
    type = string
    description = "The number for this action."
}

# Access inforation for vSphere cluster
variable "vsphere_server" {
    type = string
    description = "The vCenter endpoint for Terraform to connect to."
}

variable "vsphere_user" {
    type = string
    description = "The vCenter user for Terraform to connect to."
}

variable "vsphere_password" {
    type = string
    description = "The vCenter password for Terraform to connect to."
}

# Resource information on vSphere
variable "vsphere_datacenter" {
    type = string
    description = "The vCenter datacenter for Terraform to connect to."
}

variable "vsphere_datastore" {
    type = string
    description = "The vCenter datastore for Terraform to connect to."
}

variable "vsphere_compute_cluster" {
    type = string
    description = "The vCenter compute cluster for Terraform to connect to."
}

variable "vsphere_network" {
    type = string
    description = "The vCenter network for Terraform to connect to."
}

# Option for creating VM
## Clone from template
variable "clone_template" {
    type = bool
    description = "Clone from existing template?"
    default = true
}

variable "vsphere_template" {
    type = string
    description = "The VM template for cloning."
}

# From local OVF file
variable "local_ovf" {
    type = bool
    description = "Clone from local OVF file?"
    default = false
}

variable "local_ovf_path" {
    type = string
    description = "The path to local OVF file."
}

# From remote OVF file
variable "remote_ovf" {
    type = bool
    description = "Clone from remote OVF file?"
    default = false
}

variable "remote_ovf_url" {
    type = string
    description = "The URL to remote OVF file."
}

# Configuration for VM
variable "vm_name" {
    type = string
    description = "The VM name for Terraform to deploy."
}

variable "vm_password" {
    type = string
    description = "The VM password of user Ubuntu for Terraform to connect to."
}

variable "vm_number" {
    type = number
    description = "The number of VMs to be created."
}

variable "vm_cpus" {
    type = number
    description = "The number of CPUs of each VM."
}

variable "vm_memory" {
    type = number
    description = "The amount of RAM of each VM by Megabyte."
}

variable "vm_disk" {
    type = string
    description = "The disk size of each VM by Gigabyte."
}