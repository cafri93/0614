resource "azurerm_subnet" "user13-subnet1" {
    name = "user13-mysubnet1"
    resource_group_name = azurerm_resource_group.user13-rg.name
    virtual_network_name = azurerm_virtual_network.user13-net.name
    address_prefixes = ["13.0.1.0/24"]
}
