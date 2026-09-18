module "tags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}

locals {
  common_tags = merge(module.tags.common_tags, var.tags)
}

resource "azurerm_user_assigned_identity" "this" {
  count = var.create_identity ? 1 : 0

  name                = var.managed_identity_name
  location            = var.location
  resource_group_name = var.managed_identity_resource_group_name
  tags                = local.common_tags
}

data "azurerm_user_assigned_identity" "existing" {
  count = var.create_identity ? 0 : 1

  name                = var.managed_identity_name
  resource_group_name = var.managed_identity_resource_group_name
}

resource "azurerm_role_assignment" "contributor" {
  count = var.manage_contributor_role ? 1 : 0

  scope                = "/subscriptions/${var.subscription_id}"
  name                 = local.contributor_assignment_name
  role_definition_name = "Contributor"
  principal_id         = local.principal_id
}
