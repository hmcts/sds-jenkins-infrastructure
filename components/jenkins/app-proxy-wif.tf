# DTS Operations - GA, used by the GA-Prod-Tenant WIF service connection.
resource "azurerm_role_assignment" "app_proxy_wif_secret_management" {
  scope                = azurerm_key_vault.jenkinskv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = "0ec60e03-4262-44ce-abcf-83e2131c9207"
}
