locals {
  web_deployment_data_dir = "${path.root}/data"

  #file_name = var.input_data_format == "json" ? "web_deploy*.json" : "web_deploy*.yaml"

  web_deploy_input_files = fileset(local.web_deployment_data_dir, "web_deploy*.json")

  web_deploy_data_map = {
    for f in local.web_deploy_input_files :
    f => jsondecode(file("${local.web_deployment_data_dir}/${f}"))
  }

}
