data "azurerm_client_config" "current" {}

data "azurerm_subscription" "sub" {
  subscription_id = data.azurerm_client_config.current.subscription_id
}

data "azurerm_resource_group" "mi" {
  name = "managed-identities-${var.env}-rg"
}

data "azurerm_resource_group" "disks_resource_group" {
  name = "disks-${var.env}-rg"
}