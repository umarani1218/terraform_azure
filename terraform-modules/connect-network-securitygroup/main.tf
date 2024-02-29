variable "azurerm_network_interface_security_group_association_network_security_group_id" {}
variable "azurerm_network_interface_security_group_association_network_interface_id" {}


# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = var.azurerm_network_interface_security_group_association_network_interface_id
  network_security_group_id = var.azurerm_network_interface_security_group_association_network_security_group_id
}