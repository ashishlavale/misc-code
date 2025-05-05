resource "azurerm_public_ip" "publicip" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "privateip" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.name
    subnet_id                     = "/subscriptions/2e2b7ea8-71a7-4e33-a116-85989b5dc3b4/resourceGroups/Project-Setup/providers/Microsoft.Network/virtualNetworks/MainNetwork/subnets/default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg-attach" {
  network_interface_id      = azurerm_network_interface.privateip.id
  network_security_group_id = "/subscriptions/2e2b7ea8-71a7-4e33-a116-85989b5dc3b4/resourceGroups/Project-Setup/providers/Microsoft.Network/networkSecurityGroups/AllowAll"
}

############# We moved to spot instance for saving the cost

# resource "azurerm_virtual_machine" "vm" {
#   name                          = var.name
#   location                      = var.rg_location
#   resource_group_name           = var.rg_name
#   network_interface_ids         = [azurerm_network_interface.privateip.id]
#   vm_size                       = var.vm_size
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/2e2b7ea8-71a7-4e33-a116-85989b5dc3b4/resourceGroups/Project-Setup/providers/Microsoft.Compute/images/azure-devops-practice"
#   }
#
#   storage_os_disk {
#     name              = "${var.name}-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#
#   os_profile {
#     computer_name  = var.name
#     admin_username = "azuser"
#     admin_password = "SwapnaAshish@25"
#   }
#
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }


resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.name
  location                        = var.rg_location
  resource_group_name             = var.rg_name
  size                            = var.vm_size
  admin_username                  = "azuser"
  admin_password                  = "SwapnaAshish@25"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.privateip.id]

  os_disk {
    name                 = "${var.name}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/2e2b7ea8-71a7-4e33-a116-85989b5dc3b4/resourceGroups/Project-Setup/providers/Microsoft.Compute/images/azure-devops-practice"


  # Spot Details
  priority        = "Spot"
  max_bid_price   = -1
  eviction_policy = "Deallocate"
}

resource "azurerm_dns_a_record" "public_dns_record" {
  depends_on          = [azurerm_linux_virtual_machine.vm]
  name                = var.name
  zone_name           = "ashishlavale5.online"
  resource_group_name = var.rg_name
  ttl                 = 3
  records             = [azurerm_public_ip.publicip.ip_address]
}


resource "azurerm_dns_a_record" "private_dns_record" {
  name                = "${var.name}-int"
  zone_name           = "ashishlavale5.online"
  resource_group_name = var.rg_name
  ttl                 = 3
  records             = [azurerm_network_interface.privateip.private_ip_address]
}

