Retrieving an existing resource group (RG) and virtual network (VNet) using the data block. The resource group name and VNet name are determined by the local variables vnet-rg and vnet_derivate, respectively.

Retrieving a specific subnet within the VNet using the data block. The subnet name is determined by the local variable websub_name.

Creating a new resource group (RG) using the azurerm_resource_group resource. The name and location of the RG are determined by the local variables rg_name and "UK South", respectively.

Creating new network interfaces (NICs) using the azurerm_network_interface resource. The NIC name and count are determined by the local variable web_tier_json, and the NIC is associated with the previously retrieved subnet.

Creating new Linux virtual machines (VMs) using the azurerm_linux_virtual_machine resource. The VM name, count, size, admin credentials, and image are determined by the local variable web_tier_json. The VMs are associated with the previously created NICs and placed within the previously created RG.
