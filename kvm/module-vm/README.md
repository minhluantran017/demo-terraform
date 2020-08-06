# KVM Virtual machine module

This Terraform module creates a set of KVM Virtual Machines for your KVM server.

# What does this module create?

- (Optional) A pool to contain VMs and disks
- A base OS image disk to clone to VM disks
- VMs and VM disks

# How to use this module?

Simple usage as below snippet:

```hcl
provider "libvirt" {
    uri = "qemu+ssh://root@kvm-host-01.example.com/system"
}

module "demo-vm-module" {
    source          = "git::https://github.com/minhluantran017/demo-terraform.git//kvm/module-vm?ref=v0.1.0"
    base_image_url  = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
    vm_name         = "demo-vm"
    vm_count        = 1                /* Number of VMs */
    vm_vcpu         = 4                /* Number of vCPU for each VM */
    vm_memory       = 8096             /* Amount of memory (in MB) for each VM */
    vm_disk         = 100000000000     /* Size of disk (in Byte) for each VM */
    ip_addresses    = [
        "192.168.10.10"
    ]
    gw_address      = "192.168.10.1"
    ssh_public_key  = "ssh-rsa 1a2b3c4d...."
}
```

For more information on variables, please read `variables.tf` in the module folder.