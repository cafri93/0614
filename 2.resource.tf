resource "azurerm_resource_group" "user13-rg" {
    name     = "user13rg"
    location = "koreacentral"

    tags = {
        environment = "Terraform Demo"
    }
}
