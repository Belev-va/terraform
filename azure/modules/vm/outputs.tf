output "vm_public_ip" {
  value = { for vm in azurerm_public_ip.lab_public_ip : vm.name => vm.ip_address }
}

output "vm_private_ip" {
  value = { for vm in azurerm_network_interface.lab_nic : vm.name => vm.private_ip_address }
}

