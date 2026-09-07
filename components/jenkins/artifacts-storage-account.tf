resource "azurerm_storage_account" "storage_account" {
  name                     = "sdsjenkinsafact${var.env}"
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


  tags = local.common_tags
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

resource "azurerm_storage_container" "job_cache" {
  name                  = "job-cache"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "job_cache" {
  storage_account_id = azurerm_storage_account.storage_account.id

  rule {
    name    = "delete-job-cache-after-30-days"
    enabled = true

    filters {
      prefix_match = ["job-cache/"]
      blob_types   = ["blockBlob"]
    }

    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = 30
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 30
      }
      version {
        delete_after_days_since_creation = 30
      }
    }
  }
}

resource "azurerm_key_vault_secret" "account_key" {
  name         = "buildlog-storage-account"
  value        = azurerm_storage_account.storage_account.primary_access_key
  key_vault_id = azurerm_key_vault.jenkinskv.id

  tags = {
    "username" = azurerm_storage_account.storage_account.name
  }
}

resource "azurerm_key_vault_secret" "job_cache_account_key" {
  name         = "jenkins-job-cache-key"
  value        = azurerm_storage_account.storage_account.primary_access_key
  key_vault_id = azurerm_key_vault.jenkinskv.id
}
