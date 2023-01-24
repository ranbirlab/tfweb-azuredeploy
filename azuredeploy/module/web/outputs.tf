/*output "private_ip" {
  value = azurerm_network_interface.nic[count.index]
}*/

output "private_ip" {
  value = [for i in range(jsondecode(local.web_tier_json).deployment.web_tier.count): azurerm_network_interface.nic[i].private_ip_address]
}

output "capability" {
  value = var.capability
}

output "environment" {
  value = var.environment
}
