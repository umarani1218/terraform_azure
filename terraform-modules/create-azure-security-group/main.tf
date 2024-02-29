variable "resource_group_name" {}
variable "resource_group_location" {}
variable "azurerm_network_security_group_name" {}
variable "nsg_rules" {}



# Create Network Security Group and rule
resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = var.azurerm_network_security_group_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
}

output "azurerm_securitygroup_id" {
  value = azurerm_network_security_group.my_terraform_nsg.id
}