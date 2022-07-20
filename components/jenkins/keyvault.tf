resource "azurerm_key_vault" "jenkinskv" {
  location                   = var.location
  name                       = var.env
  resource_group_name        = azurerm_resource_group.rg.name
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  enable_rbac_authorization  = true
  tags                       = module.tags.common_tags

}

resource "azurerm_key_vault" "jenkinskv-prod" {
  count                      = var.env == "prod" ? 0 : 1
  location                   = var.location
  name                       = var.env
  resource_group_name        = azurerm_resource_group.rg.name
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  enable_rbac_authorization  = true
  tags                       = module.tags.common_tags

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

resource "azurerm_key_vault_secret" "disk2" {
  name         = "jenkins-disk-id"
  value        = azurerm_managed_disk.disk.id
  key_vault_id = azurerm_key_vault.jenkinskv-prod.id
}

resource "random_password" "jenkins-agent-password" {
  length  = 16
  special = true
  lower   = true
  upper   = true
  number  = true
}

resource "random_password" "jenkins-agent-password2" {
  length  = 16
  special = true
  lower   = true
  upper   = true
  number  = true
}


resource "azurerm_key_vault_secret" "jenkins-agent-password" {
  name         = "jenkins-agent-password"
  value        = random_password.jenkins-agent-password.result
  key_vault_id = azurerm_key_vault.jenkinskv.id
}

resource "azurerm_key_vault_secret" "subscription_id" {
  name         = "subscription-id"
  value        = data.azurerm_client_config.current.subscription_id
  key_vault_id = azurerm_key_vault.jenkinskv.id
}

resource "azurerm_key_vault_secret" "env_subscription_id" {
  for_each     = data.azurerm_client_config.current.subscription_id == "6c4d2513-a873-41b4-afdd-b05a33206631" ? local.ptl : local.ptlsbox
  name         = "${each.key}-subscription-id"
  value        = each.value
  key_vault_id = azurerm_key_vault.jenkinskv.id
}
