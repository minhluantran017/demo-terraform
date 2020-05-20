provider "libvirt" {
  uri = "qemu+ssh://${var.kvm_user}@${var.kvm_ip}/system?socket=/var/run/libvirt/libvirt-sock"
}

terraform {
  required_version = ">= 0.12"
}