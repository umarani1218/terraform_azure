variable "resource_group_name" {}
variable "azurerm_subnet_name" {}
variable "azurerm_subnet_virtual_network_name" {}
variable "azurerm_subnet_address_prefixes" {}

# Create subnet
resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = var.azurerm_subnet_name
  resource_group_name  =  var.resource_group_name
  virtual_network_name = var.azurerm_subnet_virtual_network_name
  address_prefixes     = var.azurerm_subnet_address_prefixes
}

output "azurerm_subnet_id" {
  value = azurerm_subnet.my_terraform_subnet.id
}