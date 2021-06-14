resource "azurerm_virtual_machine" "web2" {
    name                  = "user13web2"
    location              = azurerm_resource_group.user13-rg.location
    resource_group_name   = azurerm_resource_group.user13-rg.name
    availability_set_id   = azurerm_availability_set.avset.id
    network_interface_ids = [azurerm_network_interface.nic2.id]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "myOsDisk2"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }
    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

 os_profile {
        computer_name  = "user13web2"
        admin_username = "azureuser"
        admin_password = "zkvmfl1993!!"
	custom_data= file("web.sh")
    }

 os_profile_linux_config {
        disable_password_authentication = false
        ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCorVzvwBC4ULke0bkzMqX894VonmygHSPbZVZmpi6JpzCvTZO8rl7cvjPXApWNk9ujca3uuUWQzdnjLy8WDuHm8ZkqLb88MrVsNPn5kDWlGWXtVJThPI3Ggp0kuIIrmgtRFhUzpTVFtbYZNyG3W9IIa3lSkktMcT1ezrWohfU8JHice5FFP5fGtTM045qhtU4qwusVA0mOZD1T/Oafoud8BMoA48fTlbk64IU+QTs5bhKsYfvKLR3gxC5wKHAqOgfEua18iMrEQHeWu2QFAyeH2iLYkq629khs7R5uNB3lKYZrJzLaR6tSJWHrFZOIfaRQ40Bn641WYT7cMy7LS4ZR7c25+V7yrjm1zzx+J1HHELbncAa24lCthHguFhHL57mlCLCvQvp5iKwOxCB5fM7VSP2YCrqvA1IlYjZdqsR3M13sNRgJEHUJbp64GIk7iwzg21gq8IxkZ5QODyVOSNUDdP4SJzjnYJYz2vLFP+64FaGfBEoFtOGUshF6D4VPUUs= azureuser@user13-admin"
        }
    }
    boot_diagnostics {
        enabled     = "true"
        storage_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}

