data "azuread_group" "directory_readers" {
  count            = var.create_identity ? 1 : 0
  display_name     = "DTS Directory Readers"
  security_enabled = true
}

data "azurerm_role_definition" "rbac_admin_role" {
  for_each = toset(var.rbac_admin_roles)

  name  = each.value
  scope = "/subscriptions/${var.subscription_id}"
}
