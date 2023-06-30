module "jenkins-webhook-relay" {
  providers = {
    azurerm.private_endpoint = azurerm.private_endpoint
  }
  source                             = "git::https://github.com/hmcts/terraform-module-jenkins-webhook-infrastructure?ref=master"
  subscription_id                    = var.subscription_id
  env                                = var.env
  product                            = var.product
  location                           = var.location
  builtFrom                          = var.builtFrom
  expiresAfter                       = var.expiresAfter
  project                            = "sds"
  servicebus_enable_private_endpoint = var.servicebus_enable_private_endpoint
  queue_name                         = var.queue_name
  zone_redundant                     = var.zone_redundant
  enable_workflow                    = var.enable_workflow
}

resource "azurerm_key_vault_secret" "logicappsecret" {
  name         = "github-jenkins-${var.env}-logicapp"
  value        = module.jenkins-webhook-relay.logicapp-trigger-endpoint
  key_vault_id = azurerm_key_vault.jenkinskv.id
}
