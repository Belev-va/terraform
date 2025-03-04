output "vm_ips" {
  value = {
    public_ip  = module.vm.vm_public_ip
    private_ip = module.vm.vm_private_ip
  }
}
