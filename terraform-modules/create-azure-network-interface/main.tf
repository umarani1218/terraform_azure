variable "resource_group_location" {}
variable "resource_group_name" {}
variable "azurerm_network_interface_name" {}
variable "azurerm_network_interface_ip_configuration_name" {}
variable "azurerm_network_interface_ip_configuration_private_ip_address_allocation" {}
variable "azurerm_network_interface_ip_configuration_subnet_id" {}
variable "azurerm_network_interface_ip_configuration_public_ip_address_id" {}

# Create network interface
resource "azurerm_network_interface" "my_terraform_nic" {
  name                = var.azurerm_network_interface_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.azurerm_network_interface_ip_configuration_name
    subnet_id                     = var.azurerm_network_interface_ip_configuration_subnet_id
    private_ip_address_allocation = var.azurerm_network_interface_ip_configuration_private_ip_address_allocation
    public_ip_address_id          = var.azurerm_network_interface_ip_configuration_public_ip_address_id
  }
}

output "azurerm_network_interface_id" {
  value = azurerm_network_interface.my_terraform_nic.id
}