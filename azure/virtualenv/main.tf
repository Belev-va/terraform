# Azure Provider source and version being used
terraform {
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "network" {
  source              = "../modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "security" {
  source              = "../modules/security"
  resource_group_name = var.resource_group_name
  location            = var.location
  vpn_cidr           = "185.70.52.76"
  allowed_ports = [
    { name = "allow-zabbix-agent", port = 10500, priority = 1002 },
    { name = "allow-zabbix-server", port = 10051, priority = 1003 },
    { name = "allow-ssh", port = 22, priority = 1004 }
  ]
}

module "vm" {
  source              = "../modules/vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.network.subnet_id
  security_group_id   = module.security.nsg_id
  vm_list = [
    { name = "lab-vm-1", size = "Standard_B2s" }
  ]

}

