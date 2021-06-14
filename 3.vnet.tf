resource "azurerm_virtual_network" "user13-net" {
    name = "user13-vnet"
    address_space = ["13.0.0.0/16"]
    location = azurerm_resource_group.user13-rg.location
    resource_group_name = azurerm_resource_group.user13-rg.name
}
