variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
} 

variable "resource_group_location" {
  type = map(string)
  default = {
    "US" = "eastus"
    "london"    = "uk-lon1"
    "frankfurt" = "de-fra1"
    "helsinki1" = "fi-hel1"
    "helsinki2" = "fi-hel2"
    "chicago"   = "us-chi1"
    "sanjose"   = "us-sjo1"
    "singapore" = "sg-sin1"
  }
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "azurerm_virtual_network_name" {
  type        = string
  default     = "lax-EPP-Vnet"
  description = "name of the virtual network"
  validation {
    condition     = var.azurerm_virtual_network_name == "lax-EPP-Vnet"
    error_message = "virtual network name is not matching"
  }
}

variable "azurerm_subnet_name" {
  type        = string
  default     = "lax-EPP-subnet"
  description = "name of the subnet"
}

variable "azurerm_virtual_network_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "value of address_space"
}

variable "azurerm_subnet_address_prefixes" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "value of address_prefixes"
}


variable "azurerm_public_ip_name" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "lax-EPP-public-ip"
}

variable "azurerm_public_ip_allocation_method" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "Dynamic"
}

variable "azurerm_network_security_group_name" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "lax-EPP-network-securitygroup"
}

variable "azurerm_network_interface_name" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "lax-EPP-nic"
}

variable "azurerm_network_interface_ip_configuration_name" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "lax-EPP-nic-configuration"
}


variable "azurerm_network_interface_ip_configuration_private_ip_address_allocation" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "Dynamic"
}


variable "azurerm_storage_account_account_tier" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "Standard"
}

variable "azurerm_storage_account_account_replication_type" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "LRS"
}

variable "azurerm_linux_virtual_machine_name" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "lax-EPP-vm"
}


variable "azurerm_linux_virtual_machine_size" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "Standard_DS1_v2"
}

variable "azurerm_linux_virtual_machine_os_disk_name" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "myOsDisk"
}

variable "azurerm_linux_virtual_machine_os_disk_caching" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "ReadWrite"
}

variable "azurerm_linux_virtual_machine_os_disk_storage_account_type" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "Premium_LRS"
}

variable "azurerm_linux_virtual_machine_source_image_reference_publisher" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "Canonical"
}

variable "azurerm_linux_virtual_machine_source_image_reference_offer" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "0001-com-ubuntu-server-jammy"
}

variable "azurerm_linux_virtual_machine_source_image_reference_sku" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "22_04-lts-gen2"
}

variable "azurerm_linux_virtual_machine_source_image_reference_version" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "latest"
}

variable "azurerm_linux_virtual_machine_computer_name" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "hostname"
}

variable "azurerm_linux_virtual_machine_admin_username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}

