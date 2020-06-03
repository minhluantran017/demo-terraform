terraform {
  # Configure local backend to store Terraform state.
  backend "local" {
    path = "/home/ubuntu/tf-states/demo-terraform/vsphere/terraform.tfstate"
  }
  required_version = ">= 0.12"
}

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}