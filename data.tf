data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "kv" {
  name                = var.azure_keyvault
  resource_group_name = var.azure_keyvault_rg
}