resource "azurerm_lb" "user13-lb" {
  name = "user13lb"
  location = azurerm_resource_group.user13-rg.location
  resource_group_name = azurerm_resource_group.user13-rg.name
  frontend_ip_configuration {
  name = "user13PublicIPAddress"
  public_ip_address_id = azurerm_public_ip.user13-publicip.id
 }
}
