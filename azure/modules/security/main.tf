resource "azurerm_network_security_group" "lab_nsg" {
  name                = "lab-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_ports" {
  for_each = { for rule in var.allowed_ports : rule.name => rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = tostring(each.value.port)
  source_address_prefix       = var.vpn_cidr
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.lab_nsg.name
  resource_group_name         = var.resource_group_name
}
