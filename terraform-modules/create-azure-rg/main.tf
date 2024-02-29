variable "resource_group_location" {}
variable "resource_group_name" {}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
}


output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}