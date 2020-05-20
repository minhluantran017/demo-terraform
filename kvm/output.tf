output "demo_terraform_ips" {
  description = "VM IP addresses"
  value = libvirt_domain.demo_terraform.*.network_interface.0.addresses
}