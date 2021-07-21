resource "azurerm_storage_account" "storage_account" {
  name                     = "sdsjenkinsartifacts${var.env}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "ZRS"

  blob_properties {
    delete_retention_policy {
      days = 14
    }
    versioning_enabled = true
  }


  tags = module.tags.common_tags
}

resource "azurerm_storage_container" "performance" {
  name                  = "performance"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "artifacts" {
  name                  = "artifacts"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_key_vault_secret" "account_key" {
  name         = "buildlog-storage-account"
  value        = azurerm_storage_account.storage_account.primary_access_key
  key_vault_id = azurerm_key_vault.jenkinskv.id

  tags = {
    "username" = azurerm_storage_account.storage_account.name
  }
}
