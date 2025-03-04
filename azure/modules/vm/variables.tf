variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}
variable "vm_list" {
  description = "Список виртуальных машин"
  type = list(object({
    name   = string
    size   = string
  }))
  default = [
    { name = "lab-vm-1", size = "Standard_B1s" }
  ]
}
