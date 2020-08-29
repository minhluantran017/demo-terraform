# Libvirt pool to contain VMs and disks
resource "libvirt_pool" "pool" {
  count         = var.create_pool ? 1 : 0
  name          = var.libvirt_pool
  type          = "dir"
  path          = "/tmp/${var.libvirt_pool}"
}

locals {
  pool          = var.create_pool ? libvirt_pool.pool[0].name : var.libvirt_pool
}

# Base image for the VMs
resource "libvirt_volume" "os_image" {
  name          = "${var.vm_name}_base_image.img"
  source        = var.base_image_url
  pool          = local.pool
}

# User-data to inject into VM
data "template_file" "user_data" {
  template      = file("${path.module}/cloud_init.cfg")
  vars = {
    SSH_PUBLIC_KEY = var.ssh_public_key
  }
}

# Network config file
data "template_file" "network_config" {
  count = var.vm_count
  template      = file("${path.module}/network_config.cfg")
  vars = {
    IPADDR      = element(var.ip_addresses, count.index)
    GW_ADDRESS  = var.gw_address
    DNS_ADDRESS = var.dns_address
  }
}

# Cloud-init disk for VMs
resource "libvirt_cloudinit_disk" "virtual_machine" {
  count         = var.vm_count
  name          = "${var.vm_name}_${count.index}.iso"
  user_data     = data.template_file.user_data.rendered
  network_config= data.template_file.network_config[count.index].rendered
  pool          = local.pool
}

# Volume for VM
resource "libvirt_volume" "virtual_machine" {
  count         = var.vm_count
  name          = "${var.vm_name}_${count.index}"
  pool          = local.pool
  size          = var.vm_disk
  base_volume_id= libvirt_volume.os_image.id
}

# Virtual machine
resource "libvirt_domain" "virtual_machine" {
  count         = var.vm_count
  name          = "${var.vm_name}_${count.index}"
  memory        = var.vm_memory
  vcpu          = var.vm_vcpu
  qemu_agent    = true
  autostart     = false
  cloudinit     = element(libvirt_cloudinit_disk.virtual_machine.*.id, count.index)
  network_interface {
    hostname    = "${var.vm_name}_${count.index}"
    macvtap     = "enp4s0f0"
    addresses   = [element(var.ip_addresses, count.index)]
    wait_for_lease = true
  }
  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
  disk {
    volume_id   = element(libvirt_volume.virtual_machine.*.id, count.index)
  }
  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
