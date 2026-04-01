data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "this" {
  for_each            = var.key_vaults
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}
