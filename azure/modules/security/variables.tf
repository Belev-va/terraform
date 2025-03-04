variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
  default     = "NP_DEVOPS_COGNITIVE_ONCE-RAW-FLURE"
}

variable "location" {
  description = "Region Azure"
  type        = string
  default     = "East US"
}

variable "vpn_cidr" {
  description = "CIDR of VPN"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_ports" {
  description = "Список портов для открытия"
  type        = list(object({
    name         = string
    port         = number
    priority     = number
  }))
}