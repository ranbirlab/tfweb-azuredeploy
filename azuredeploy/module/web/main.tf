# get a VNet RG
# Get Resources from a Resource Group
data "azurerm_resources" "vnetrg" {
  resource_group_name = local.vnet-rg
}

# Get a virtual network within the resource group
data "azurerm_virtual_network" "vnet" {
  name                = "${lookup(var.vnet_map, local.vnet_derivate)}"
  resource_group_name = data.azurerm_resources.vnetrg.resource_group_name
}

# Deploying resources for Web
#Get the subnet in the VNET
data "azurerm_subnet" "subnet" {
  name                 = local.websub_name
  resource_group_name  = data.azurerm_resources.vnetrg.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

# Create RG
resource "azurerm_resource_group" "myrg" {
  name     = local.rg_name
  location = "UK South"
}

#Create a new NIC using exiting manual VNET & Subnet
resource "azurerm_network_interface" "nic" {
name = "${jsondecode(local.web_tier_json).deployment.app_name}-${jsondecode(local.web_tier_json).deployment.deployment_type}vmnic-${count.index+1}"
count = jsondecode(local.web_tier_json).deployment.web_tier.count
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#Create a VM using exiting VNET & Subnet in a RG for VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${jsondecode(local.web_tier_json).deployment.capability}-${jsondecode(local.web_tier_json).deployment.app_name}-${jsondecode(local.web_tier_json).deployment.environment}-${jsondecode(local.web_tier_json).deployment.deployment_type}-vm-${count.index+1}"
  count                           = jsondecode(local.web_tier_json).deployment.web_tier.count
  resource_group_name             = azurerm_resource_group.myrg.name
  location                        = azurerm_resource_group.myrg.location
  size                            = jsondecode(local.web_tier_json).deployment.web_tier.recommended_instance_type
  admin_username                  = local.admin_username
  admin_password                  = "Azurepassword@12345"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = jsondecode(local.web_tier_json).deployment.web_tier.marketplace_image.publisher
    offer     = jsondecode(local.web_tier_json).deployment.web_tier.marketplace_image.offer
    sku       = jsondecode(local.web_tier_json).deployment.web_tier.marketplace_image.sku
    version   = jsondecode(local.web_tier_json).deployment.web_tier.marketplace_image.version
  }
}

