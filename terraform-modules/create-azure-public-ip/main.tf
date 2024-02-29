variable "resource_group_name" {}
variable "resource_group_location" {}
variable "azurerm_public_ip_name" {}
variable "azurerm_public_ip_allocation_method" {}


# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = var.azurerm_public_ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.azurerm_public_ip_allocation_method
}


output "azurerm_public_ip_id" {
  value = azurerm_public_ip.my_terraform_public_ip.id
}