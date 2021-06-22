data "azurerm_client_config" "current" {}

data "azurerm_subscription" "sub" {
  subscription_id = data.azurerm_client_config.current.subscription_id
}

data "azurerm_key_vault" "kv" {
  name                = "${lower(replace(data.azurerm_subscription.sub.display_name, "-", ""))}kv"
  resource_group_name = "genesis-rg"
}

data "azurerm_resource_group" "mi" {
  name = "managed-identities-${var.env}-rg"
}

