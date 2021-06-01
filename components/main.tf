/**
 * # Jenkins Infrastructure Code for SDS platform
 *
 *
 *
 */


module "tags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = lower(var.environment)
  product     = var.product
  builtFrom   = var.builtFrom
}


resource "azurerm_resource_group" "rg" {
  name     = "${var.product}-${var.environment}-rg"
  location = var.location
  tags     = module.tags.common_tags
}

resource "azurerm_managed_disk" "disk" {
  name                 = "${var.product}-${var.environment}-disk"
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1024"
  tags                 = module.tags.common_tags

}

resource "azurerm_user_assigned_identity" "usermi" {
  resource_group_name = data.azurerm_resource_group.mi.name
  location            = var.location
  name                = "${var.product}-${var.environment}-mi"
  tags                = module.tags.common_tags
}

resource "azurerm_role_assignment" "miroles" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subidcontributer" {

  for_each             = data.azurerm_client_config.current.subscription_id == "6c4d2513-a873-41b4-afdd-b05a33206631" ? local.ptl : local.sboxptl
  scope                = "/subscriptions/${each.value}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "subiduseraccessadmin" {

  for_each             = data.azurerm_client_config.current.subscription_id == "6c4d2513-a873-41b4-afdd-b05a33206631" ? local.ptl : local.sboxptl
  scope                = "/subscriptions/${each.value}"
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_role_assignment" "kv" {
  scope                = data.azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_key_vault_secret" "disk" {
  name         = "jenkins-disk-id"
  value        = azurerm_managed_disk.disk.id
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "db" {
  name         = "cosmosdb-token-key"
  value        = azurerm_cosmosdb_account.cosmosdb.primary_master_key
  key_vault_id = data.azurerm_key_vault.kv.id
}

