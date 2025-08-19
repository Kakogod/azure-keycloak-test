variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "keycloaktest"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "westeurope"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_user" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

