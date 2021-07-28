module "tags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = lower(var.env)
  product     = var.product
  builtFrom   = var.builtFrom
}

resource "azurerm_resource_group" "rg" {
  name     = "jenkins-state-${var.env}"
  location = var.location

  tags = module.tags.common_tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "sdsstate${var.env}"
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

resource "azurerm_storage_container" "container" {
  name                  = "tfstate-${var.env}"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_key_vault_secret" "env_subscription_id" {
  count        = var.env == "ptl" ? 1 : 0
  name         = "${var.env}-subscription-id"
  value        = var.prod_subscription_id
  key_vault_id = data.azurerm_key_vault.jenkinskv.id
}