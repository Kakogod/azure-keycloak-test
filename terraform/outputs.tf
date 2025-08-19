output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "vm_admin_user" {
  value = var.admin_user
}

