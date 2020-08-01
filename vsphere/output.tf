output "VM_LOCAL_OVF_IP_ADDRESSES" {
  value = vsphere_virtual_machine.vmFromLocalOvf.*.default_ip_address
}

output "VM_REMOTE_OVF_IP_ADDRESSES" {
  value = vsphere_virtual_machine.vmFromRemoteOvf.*.default_ip_address
}

output "VM_FROM_TEMPLATE_IP_ADDRESSES" {
  value = vsphere_virtual_machine.vmFromTemplate.*.default_ip_address
}