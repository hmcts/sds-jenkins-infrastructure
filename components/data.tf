data "azurerm_client_config" "current" {}

data "azurerm_subscription" "sub" {
  subscription_id = data.azurerm_client_config.current.subscription_id
}

data "azurerm_key_vault" "kv" {
  name                = "dts${data.azurerm_subscription.sub.display_name}${var.environment}kv"
  resource_group_name = "genesis-rg"
}

data "azurerm_resource_group" "mi" {
  name = "managed-identities-${var.environment}-rg"
}

