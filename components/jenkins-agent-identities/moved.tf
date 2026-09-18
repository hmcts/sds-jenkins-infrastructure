moved {
  from = azurerm_role_assignment.storage_account_data_contributor[0]
  to   = azurerm_role_assignment.rbac_administrator["Storage Account Data Contributor"]
}

moved {
  from = azurerm_role_assignment.storage_account_contributor[0]
  to   = azurerm_role_assignment.rbac_administrator["Storage Account Contributor"]
}
