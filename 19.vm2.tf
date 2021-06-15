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
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDMWuogbu7R5wCUNqEZMm3kZ13DPfA9R3ZJMn01sc8c6d5FS0ZDY0aTAIDxwafJC2FI90X5ghPwEMbww6pe3xo0p87wS/sHknpcNd5tCOsJNwagQ2MyfeagV5WpvTv511Wkg9uXBMJ2wpvQerXy9mGtqXdMXa2++EMC1xikQuNarxI72xuzMlt+nLZzMYsMEsh9MyvRPlHvQFx8Djd7J1IVriBsCrAKLbTVw3sHvG2w/Ea0jsyOhhflo4ytNeB4goUY7zGE8VLzkEmbWwbv42PHPO0VgrwpvSYoVEYOngkKMNw7hGzTeHt1y1PO3VF8a+LALczq249FPwYb7xL2SgzTpvD70Enuh39NsOZlj7QFssocv9FxDyejZdfReYxWgL2ufnMgQLByy8NI6KN2gRl97f2XO5F6ypxmgktvK0Uxj2ZkEOIvYbWKbbO1eYGeRft9gTElnIWJgqcI4kNPeTsvV36kHYPQMruakjKQ64HLNbAN6T8QIvJeXLK3jhMxxs5UlgX2nMgflFu+Fpa2EQzeHffMq/Fu55uUGvDZp6wUasYbC9UcNgvnOE1v9XaDAgyP4ee7M+4g/Mg9UDApa2fkxQrVR4fPGfd7Nmb91MUjovo57Pl/fJXiO2mpx4+z18bDTgEWrPlMzWlfNhiN53iON5OYQtCXOguy+Gr6PENNnw== azureuser@user13-admin"
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

