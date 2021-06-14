resource "azurerm_virtual_machine" "web1" {
    name                  = "user13web1"
    location              = azurerm_resource_group.user13-rg.location
    resource_group_name   = azurerm_resource_group.user13-rg.name
    availability_set_id   = azurerm_availability_set.avset.id
    network_interface_ids = [azurerm_network_interface.nic1.id]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "myOsDisk"
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
        computer_name  = "user13web1"
        admin_username = "azureuser"
        admin_password = "Pa55w.rd1234"
	custom_data = file("web.sh")
    }

 os_profile_linux_config {
        disable_password_authentication = false
        ssh_keys {
	    ## ssh-keygen 명령어를 통해 Private Key(id_rsa)와 Public Key(id_rsa.pub)파일 생성
            ## 서버 접근을 위해 관리 서버에서 생성한 id_rsa.pub 파일을 가상서버로 복사
            path     = "/home/azureuser/.ssh/authorized_keys"   ## 가상 서버에 복사되는 위치
	    ## id_rsa.pub 파일 내용을 아래 key_data에 넣어줌 (무조건 한줄로!!!)
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCorVzvwBC4ULke0bkzMqX894VonmygHSPbZVZmpi6JpzCvTZO8rl7cvjPXApWNk9ujca3uuUWQzdnjLy8WDuHm8ZkqLb88MrVsNPn5kDWlGWXtVJThPI3Ggp0kuIIrmgtRFhUzpTVFtbYZNyG3W9IIa3lSkktMcT1ezrWohfU8JHice5FFP5fGtTM045qhtU4qwusVA0mOZD1T/Oafoud8BMoA48fTlbk64IU+QTs5bhKsYfvKLR3gxC5wKHAqOgfEua18iMrEQHeWu2QFAyeH2iLYkq629khs7R5uNB3lKYZrJzLaR6tSJWHrFZOIfaRQ40Bn641WYT7cMy7LS4ZR7c25+V7yrjm1zzx+J1HHELbncAa24lCthHguFhHL57mlCLCvQvp5iKwOxCB5fM7VSP2YCrqvA1IlYjZdqsR3M13sNRgJEHUJbp64GIk7iwzg21gq8IxkZ5QODyVOSNUDdP4SJzjnYJYz2vLFP+64FaGfBEoFtOGUshF6D4VPUUs= azureuser@user13-admin"

            # key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJ8fBKU2PfFgEpbALeFQwMgMGTg6adjgSnpT+3y9Y4IKXgcR6Qjpo56ccjL4gHm3wRg1GbMPxgYvLboOr5AyqTvyFvPuUujf1RF2BlI6SJyTBd+vaxID8MBfWUj3sOX7knvTY6CKWI084Zjm2JVVhZYFbrXhVzVZa0upLeyic1ayDVqm1MmQMilB1WLW9X6NSt5StzvDy/86Zq9/EfQTkRS9vl/mv2C25XOprV2lYi/ecQ8R0DtJ2enEJKrTw6AkDNPd1KrS4QD3vffHvGqACvpGXkEwM/tfhPYHnAY6V6adC7yi6lzT5QfCDrA8c01X8enxVclEGFa/NzL0kXkFNV user13@user13admin"
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

