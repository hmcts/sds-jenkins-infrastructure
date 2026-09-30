data "azuread_group" "directory_readers" {
  count            = var.create_identity ? 1 : 0
  display_name     = "DTS Directory Readers"
  security_enabled = true
}

data "azurerm_subscription" "current" {}

data "azuread_group" "aks_administrators" {
  count            = var.manage_aks_administrators_group ? 1 : 0
  display_name     = "DTS AKS Administrators (sub:${lower(data.azurerm_subscription.current.display_name)})"
  security_enabled = true
}

data "azurerm_role_definition" "rbac_admin_role" {
  for_each = toset(var.rbac_admin_roles)

  name  = each.value
  scope = "/subscriptions/${var.subscription_id}"
}
