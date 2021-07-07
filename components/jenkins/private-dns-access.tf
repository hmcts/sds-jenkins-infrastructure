data "azurerm_resource_group" "dns" {
  provider = azurerm.private_dns

  name = "core-infra-intsvc-rg"
}

resource "azurerm_role_assignment" "dns_contributor" {
  provider = azurerm.private_dns

  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
  role_definition_name = "Private DNS Zone Contributor"
  scope                = data.azurerm_resource_group.dns.id
}
