resource "azurerm_public_ip" "lab_public_ip" {
  for_each            = { for vm in var.vm_list : vm.name => vm }
  name                = "${each.key}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "lab_nic" {
  for_each            = { for vm in var.vm_list : vm.name => vm }
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.lab_public_ip[each.key].id
  }
}
  resource "azurerm_network_interface_security_group_association" "lab_nic_nsg" {
    for_each                  = { for vm in var.vm_list : vm.name => vm }
    network_interface_id      = azurerm_network_interface.lab_nic[each.key].id
    network_security_group_id = var.security_group_id
  }

resource "azurerm_linux_virtual_machine" "lab_vm" {
  for_each            = { for vm in var.vm_list : vm.name => vm }
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = each.value.size
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.lab_nic[each.key].id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("C:/Users/Felix/.ssh/id_rsa.pub")
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
