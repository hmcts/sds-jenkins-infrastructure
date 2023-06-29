module "servicebus-queue" {
  depends_on          = [module.servicebus-namespace]
  source              = "git::https://github.com/hmcts/terraform-module-servicebus-queue?ref=master"
  name                = var.queue_name
  namespace_name      = module.servicebus-namespace.name
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

module "servicebus-namespace" {
  providers = {
    azurerm.private_endpoint = azurerm.private_endpoint
  }
  source                  = "git::https://github.com/hmcts/terraform-module-servicebus-namespace?ref=master"
  name                    = "github-jenkins-${var.env}"
  resource_group_name     = azurerm_resource_group.azure_resource_group.name
  location                = var.location
  env                     = var.env
  common_tags             = module.ctags.common_tags
  project                 = var.project
  enable_private_endpoint = false #var.servicebus_enable_private_endpoint
  zone_redundant          = var.zone_redundant
}


resource "azurerm_api_connection" "connection" {
  name                = "github-sb-jenkins-con"
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  managed_api_id      = data.azurerm_managed_api.api.id

  parameter_values = {
    connectionString = module.servicebus-namespace.primary_send_and_listen_connection_string
  }

  tags = module.ctags.common_tags

  lifecycle {

    ignore_changes = ["parameter_values"]
  }
}