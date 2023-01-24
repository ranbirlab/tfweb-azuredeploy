module "web-deploy" {
  source   = "./module/web"
  for_each = local.web_deploy_data_map

  capability  = each.value.deployment.capability
  environment = each.value.deployment.environment
}