resource "azurerm_user_assigned_identity" "usermi2" {
  count               = var.env == "ptlsbox" ? 1 : 0
  resource_group_name = data.azurerm_resource_group.mi.name
  location            = var.location
  name                = "dtspo-29750"
  tags                = local.common_tags
}

resource "azurerm_role_assignment" "vm_contributor" {
  count = var.env == "ptlsbox" ? 1 : 0

  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi2[0].principal_id
}

resource "azurerm_role_assignment" "network_contributor" {
  count = var.env == "ptlsbox" ? 1 : 0

  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi2[0].principal_id
}

resource "azurerm_role_assignment" "compute_gallery_image_reader" {
  count = var.env == "ptlsbox" ? 1 : 0

  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Compute Gallery Image Reader"
  principal_id         = azurerm_user_assigned_identity.usermi2[0].principal_id
}

resource "azurerm_role_assignment" "hmctsacrpull2" {
  count = var.env == "ptlsbox" ? 1 : 0

  scope                = data.azurerm_resource_group.acr_rg.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.usermi2[0].principal_id
}
