variable "resource_group_location" {}
variable "resource_group_name" {}
variable "azurerm_virtual_network_name" {}
variable "azurerm_virtual_network_address_space" {}


# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = var.azurerm_virtual_network_name
  address_space       = var.azurerm_virtual_network_address_space
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

output "azurerm_virtual_network_name" {
  value = azurerm_virtual_network.my_terraform_network.name
}
