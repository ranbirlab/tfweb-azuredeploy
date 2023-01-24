locals {

 # vnet_name      = "TAX-DEV-VNET"
  vnet-rg        = "TAX-DEV-NETWORK-RG"
  websub_name    = "DEV-WEB-SUBNET"
  appsub_name    = "DEV-APP-SUBNET"
  datasub_name   = "DEV-DATA-SUBNET"
  admin_username = "admin_user"
#  rg_name        = var.input_data_format == "json" ? local.web_deploy_data_map.deployment.app_name : var.rg_name
rg_name    = format("%s-%s-%s-RG", "tax", "sequence", "dev")

vnet_derivate = format("%s:%s", var.capability, var.environment)

}

locals {
  web_tier_json = file(var.web_tier_json_path)
}

