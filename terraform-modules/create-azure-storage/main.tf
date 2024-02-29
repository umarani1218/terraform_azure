variable "resource_group_name" {}
variable "resource_group_location" {}
variable "azurerm_storage_account_account_tier" {}
variable "azurerm_storage_account_account_replication_type" {}

# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
      resource_group_name = var.resource_group_name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "my_storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  account_tier             = var.azurerm_storage_account_account_tier
  account_replication_type = var.azurerm_storage_account_account_replication_type
}       

output "azure-storage-primary_blob_endpoint" {
  value = azurerm_storage_account.my_storage_account.primary_blob_endpoint
}