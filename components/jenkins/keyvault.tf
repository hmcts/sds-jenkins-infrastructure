resource "azurerm_key_vault" "jenkinskv" {
  location                   = var.location
  name                       = "ptlsbox"
  resource_group_name        = azurerm_resource_group.rg.name
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.usermi.principal_id

    key_permissions = [
      "Get",
      "List"
    ]

    secret_permissions = [
      "Get",
      "List"
    ]
  }
}

resource "azurerm_role_assignment" "jenkinskvrole" {
  scope                = azurerm_key_vault.jenkinskv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}

resource "azurerm_key_vault_secret" "disk" {
  name         = "jenkins-disk-id"
  value        = azurerm_managed_disk.disk.id
  key_vault_id = azurerm_key_vault.jenkinskv.id
}

resource "azurerm_key_vault_secret" "db" {
  name         = "cosmosdb-token-key"
  value        = azurerm_cosmosdb_account.cosmosdb.primary_master_key
  key_vault_id = azurerm_key_vault.jenkinskv.id
}