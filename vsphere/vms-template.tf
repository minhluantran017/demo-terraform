data "vsphere_virtual_machine" "template_from_ovf" {
  name          = var.vsphere_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vmFromTemplate" {
  count            = var.clone_template ? var.vm_number : 0
  name             = "${var.vm_name}-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpus
  memory   = var.vm_memory
  nested_hv_enabled = true
  
  guest_id = "ubuntu64Guest"
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout = 10
  ignored_guest_ips = ["172.17.0.1"]
  network_interface {
    network_id   = data.vsphere_network.network.id
  }

  disk {
    name             = "${var.vsphere_template}-disk001.vmdk"
    size             = var.vm_disk
    thin_provisioned = data.vsphere_virtual_machine.template_from_ovf.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template_from_ovf.id
  }
  connection {
    type     = "ssh"
    user     = "ubuntu"
    password = var.vm_password
    /* Or using SSH key
    private_key = file("/home/ubuntu/.ssh/id_rsa")
    */
    host     = self.default_ip_address
  }
  provisioner "remote-exec" {
    inline = [
      "echo Hello",
      "ls -la"
    ]
  }
}
