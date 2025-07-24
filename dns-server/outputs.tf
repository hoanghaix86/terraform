output "instance_ip_addr" {
  value = proxmox_vm_qemu.dns_server.default_ipv4_address
}