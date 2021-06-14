resource "azurerm_lb_probe" "user13-lb-probe" {
    resource_group_name = azurerm_resource_group.user13-rg.name
    loadbalancer_id = azurerm_lb.user13-lb.id
    name = "http-probe"
    protocol = "Http"
    request_path = "/"
    port = 80
}
