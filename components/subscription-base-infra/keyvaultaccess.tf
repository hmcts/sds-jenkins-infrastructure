data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "subscription" {
  name                = "dtssharedservices${var.env}kv"
  resource_group_name = "genesis-rg"
}

resource "azurerm_key_vault_access_policy" "subscriptionaccess" {
  key_vault_id = data.azurerm_key_vault.subscription.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.jenkins_identity_object_id

  secret_permissions = [
    "Get",
    "List",
  ]
}