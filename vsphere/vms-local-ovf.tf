resource "vsphere_virtual_machine" "vmFromLocalOvf" {
  count            = var.local_ovf ? var.vm_number : 0
  name             = "${var.vm_name}-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout = 10

  ovf_deploy {
    local_ovf_path = var.local_ovf_path
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    password = var.vm_password
    /* Or using SSH key
    private_key = file("/home/ubuntu/.ssh/id_rsa")
    */
    host     = self.guest_ip_addresses.0
  }
  provisioner "remote-exec" {
    inline = [
      "echo Hello",
      "ls -la"
    ]
  }
}
