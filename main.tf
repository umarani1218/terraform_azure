module "azure-resource-group" {
  source = "./terraform-modules/create-azure-rg"

  resource_group_location = var.resource_group_location.US
  resource_group_name = var.resource_group_name
}

module "azure-ssh" {
  source = "./terraform-modules/create-azure-ssh"

  resource_group_location = module.azure-resource-group.resource_group_location
  resource_group_id = module.azure-resource-group.resource_group_id
}

module "azure_vnet" {
  source = "./terraform-modules/create-azure-network"

  resource_group_location = module.azure-resource-group.resource_group_location
  resource_group_name = module.azure-resource-group.resource_group_name
  azurerm_virtual_network_name= var.azurerm_virtual_network_name
  azurerm_virtual_network_address_space = var.azurerm_virtual_network_address_space
}

module "azure_subnet" {
  source = "./terraform-modules/create-azure-subnet"

  azurerm_subnet_name = var.azurerm_subnet_name
  resource_group_name = module.azure-resource-group.resource_group_name
  azurerm_subnet_virtual_network_name = module.azure_vnet.azurerm_virtual_network_name
  azurerm_subnet_address_prefixes = var.azurerm_subnet_address_prefixes
}

module "azure_public_ip" {
  source = "./terraform-modules/create-azure-public-ip"

  resource_group_location = module.azure-resource-group.resource_group_location
  resource_group_name = module.azure-resource-group.resource_group_name
  azurerm_public_ip_name = var.azurerm_public_ip_name
  azurerm_public_ip_allocation_method = var.azurerm_public_ip_allocation_method
}

module "azure-securitygroup" {
  source = "./terraform-modules/create-azure-security-group"

  resource_group_location = module.azure-resource-group.resource_group_location
  resource_group_name = module.azure-resource-group.resource_group_name
  azurerm_network_security_group_name = var.azurerm_network_security_group_name
  nsg_rules = var.nsg_rules
}

module "azure-network-interface" {
  source = "./terraform-modules/create-azure-network-interface"

  resource_group_name = module.azure-resource-group.resource_group_name
  resource_group_location = module.azure-resource-group.resource_group_location
  azurerm_network_interface_ip_configuration_subnet_id = module.azure_subnet.azurerm_subnet_id
  azurerm_network_interface_ip_configuration_public_ip_address_id = module.azure_public_ip.azurerm_public_ip_id
  azurerm_network_interface_name = var.azurerm_network_interface_name
  azurerm_network_interface_ip_configuration_name = var.azurerm_network_interface_ip_configuration_name
  azurerm_network_interface_ip_configuration_private_ip_address_allocation = var.azurerm_network_interface_ip_configuration_private_ip_address_allocation
}

module "azure-connect-nwtwork-securitygroup" {
  source = "./terraform-modules/connect-network-securitygroup"

  azurerm_network_interface_security_group_association_network_security_group_id = module.azure-securitygroup.azurerm_securitygroup_id
  azurerm_network_interface_security_group_association_network_interface_id = module.azure-network-interface.azurerm_network_interface_id
}

module azure-storage-account { 
  source = "./terraform-modules/create-azure-storage"

  resource_group_location = module.azure-resource-group.resource_group_location
  resource_group_name = module.azure-resource-group.resource_group_name
  azurerm_storage_account_account_tier = var.azurerm_storage_account_account_tier
  azurerm_storage_account_account_replication_type = var.azurerm_storage_account_account_replication_type  

}

module "azure-vm" {
  source = "./terraform-modules/create-azure-vm"

  resource_group_location = module.azure-resource-group.resource_group_location
  resource_group_name = module.azure-resource-group.resource_group_name

  azurerm_network_interface_security_group_association_network_interface_id = module.azure-network-interface.azurerm_network_interface_id
  azurerm_storage_account_uri = module.azure-storage-account.azure-storage-primary_blob_endpoint

  azurerm_linux_virtual_machine_name = var.azurerm_linux_virtual_machine_name
  azurerm_linux_virtual_machine_size = var.azurerm_linux_virtual_machine_size
  azurerm_linux_virtual_machine_os_disk_name = var.azurerm_linux_virtual_machine_os_disk_name
  azurerm_linux_virtual_machine_os_disk_caching = var.azurerm_linux_virtual_machine_os_disk_caching
  azurerm_linux_virtual_machine_os_disk_storage_account_type = var.azurerm_linux_virtual_machine_os_disk_storage_account_type
  azurerm_linux_virtual_machine_source_image_reference_publisher = var.azurerm_linux_virtual_machine_source_image_reference_publisher
  azurerm_linux_virtual_machine_source_image_reference_offer = var.azurerm_linux_virtual_machine_source_image_reference_offer
  azurerm_linux_virtual_machine_source_image_reference_sku = var.azurerm_linux_virtual_machine_source_image_reference_sku
  azurerm_linux_virtual_machine_source_image_reference_version = var.azurerm_linux_virtual_machine_source_image_reference_version
  azurerm_linux_virtual_machine_computer_name = var.azurerm_linux_virtual_machine_computer_name
  azurerm_linux_virtual_machine_admin_username = var.azurerm_linux_virtual_machine_admin_username

  ssh_public_key = module.azure-ssh.key_data
  ssh_private_key = module.azure-ssh.key_data_private

}   