provider "libvirt" {
  uri = "qemu+ssh://localhost/system?socket=/var/run/libvirt/libvirt-sock"
}

terraform {
  required_version = ">= 0.12"
}