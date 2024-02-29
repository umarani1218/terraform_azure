variable "resource_group_location" {}
variable "resource_group_name" {}

variable "azurerm_linux_virtual_machine_name" {}
variable "azurerm_linux_virtual_machine_size" {}
variable "azurerm_linux_virtual_machine_os_disk_name" {}
variable "azurerm_linux_virtual_machine_os_disk_caching" {}
variable "azurerm_linux_virtual_machine_os_disk_storage_account_type" {}
variable "azurerm_linux_virtual_machine_source_image_reference_publisher" {}
variable "azurerm_linux_virtual_machine_source_image_reference_offer" {}
variable "azurerm_linux_virtual_machine_source_image_reference_sku" {}
variable "azurerm_linux_virtual_machine_source_image_reference_version" {}
variable "azurerm_linux_virtual_machine_computer_name" {}
variable "azurerm_linux_virtual_machine_admin_username" {}

variable "azurerm_network_interface_security_group_association_network_interface_id" {}
variable "azurerm_storage_account_uri" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}


                         

# Create virtual machine
resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  name                  = var.azurerm_linux_virtual_machine_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  network_interface_ids = [var.azurerm_network_interface_security_group_association_network_interface_id]
  size                  = var.azurerm_linux_virtual_machine_size

  os_disk {
    name                 = var.azurerm_linux_virtual_machine_os_disk_name
    caching              = var.azurerm_linux_virtual_machine_os_disk_caching
    storage_account_type = var.azurerm_linux_virtual_machine_os_disk_storage_account_type
  }


  source_image_reference {
    publisher = var.azurerm_linux_virtual_machine_source_image_reference_publisher
    offer     = var.azurerm_linux_virtual_machine_source_image_reference_offer
    sku       = var.azurerm_linux_virtual_machine_source_image_reference_sku
    version   = var.azurerm_linux_virtual_machine_source_image_reference_version
  }


  computer_name  = var.azurerm_linux_virtual_machine_computer_name
  admin_username = var.azurerm_linux_virtual_machine_admin_username


  admin_ssh_key {
    username   = var.azurerm_linux_virtual_machine_admin_username
    public_key = var.ssh_public_key
  }

  boot_diagnostics {
    storage_account_uri = var.azurerm_storage_account_uri
  }

  
	connection {
        host = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
        user = "azureadmin"
        type = "ssh"
        private_key = var.ssh_private_key
        timeout = "4m"
        agent = false
    }
	
	provisioner "file" {
        source = "testfile.txt"
        destination = "/home/azureadmin/"
    }

    provisioner "remote-exec" {
        inline = [
          "sudo apt-get update"
        ]
    }

    provisioner "local-exec" {
        command = "echo  completed >> env_vars.txt"
	}
	

}


output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}

