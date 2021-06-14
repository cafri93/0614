resource "azurerm_lb_backend_address_pool" "user13-bpepool" {
    resource_group_name = azurerm_resource_group.user13-rg.name
    loadbalancer_id = azurerm_lb.user13-lb.id
    name = "user13-BackEndAddressPool"
}
