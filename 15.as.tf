resource "azurerm_availability_set" "avset" {
 name                         = "avset"
 location                     = azurerm_resource_group.user13-rg.location
 resource_group_name          = azurerm_resource_group.user13-rg.name
 platform_fault_domain_count  = 2
 platform_update_domain_count = 2
 managed                      = true
}

