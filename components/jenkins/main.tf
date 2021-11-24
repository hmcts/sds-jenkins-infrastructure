/**
 * # Jenkins Infrastructure Code for SDS platform
 *
 *
 *
 */


module "tags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = lower(var.env)
  product     = var.product
  builtFrom   = var.builtFrom
}


resource "azurerm_resource_group" "rg" {
  name     = "${var.product}-${var.env}-rg"
  location = var.location
  tags     = module.tags.common_tags
}

resource "azurerm_managed_disk" "disk" {
  name                 = "${var.product}-${var.env}-disk"
  location             = var.location
  resource_group_name  = data.azurerm_resource_group.disks_resource_group.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1024"
  tags                 = module.tags.common_tags
  zones                = ["1"]

}

resource "azurerm_user_assigned_identity" "usermi" {
  resource_group_name = data.azurerm_resource_group.mi.name
  location            = var.location
  name                = "jenkins-${var.env}-mi"
  tags                = module.tags.common_tags
}

resource "azurerm_role_assignment" "miroles" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subidcontributer" {

  for_each             = data.azurerm_client_config.current.subscription_id == "6c4d2513-a873-41b4-afdd-b05a33206631" ? local.ptl : local.ptlsbox
  scope                = "/subscriptions/${each.value}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subiduseraccessadmin" {

  for_each             = data.azurerm_client_config.current.subscription_id == "6c4d2513-a873-41b4-afdd-b05a33206631" ? local.ptl : local.ptlsbox
  scope                = "/subscriptions/${each.value}"
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "hmctsacrpull" {
  scope                = data.azurerm_resource_group.acr_rg.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}