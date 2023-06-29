module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}
data "azurerm_managed_api" "api" {
  name     = "servicebus"
  location = var.location
}
data "local_file" "logic_app" {
  filename = "../../modules/jenkins-webhook-relay/workflow.json"
}