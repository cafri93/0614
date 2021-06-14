resource "azurerm_network_interface" "nic2" {
    name                = "myNIC2"
    location = azurerm_resource_group.user13-rg.location
    resource_group_name = azurerm_resource_group.user13-rg.name

    ip_configuration {
        name                          = "myNicConfiguration2"
        subnet_id                     = azurerm_subnet.user13-subnet1.id
        private_ip_address_allocation = "Dynamic"
#        public_ip_address_id          = azurerm_public_ip.user13-publicip.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_network_interface_security_group_association" "nic-nsg-association2" {
  network_interface_id      = azurerm_network_interface.nic2.id
  network_security_group_id = azurerm_network_security_group.mynsg.id
}

resource "azurerm_network_interface_backend_address_pool_association" "backendPool2" {
  network_interface_id    = azurerm_network_interface.nic2.id
  ip_configuration_name   = "myNicConfiguration2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.user13-bpepool.id 
}

resource "azurerm_network_interface_nat_rule_association" "natrule2" {
  network_interface_id  = azurerm_network_interface.nic2.id
  ip_configuration_name = "myNicConfiguration2"
  nat_rule_id           = azurerm_lb_nat_rule.natrule2.id
}
