resource "azurerm_storage_account" "mystorageaccount" {
    name                = "user13vm1diagestorage1"
    resource_group_name = azurerm_resource_group.user13-rg.name
    location = azurerm_resource_group.user13-rg.location
    account_replication_type = "LRS"
    account_tier = "Standard"

    tags = {
        environment = "Terraform Demo"
    }
}

