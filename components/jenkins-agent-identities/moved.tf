moved {
  from = azurerm_role_assignment.storage_account_data_contributor[0]
  to   = azurerm_role_assignment.constrained_storage_role["Storage Account Data Contributor"]
}

moved {
  from = azurerm_role_assignment.storage_account_contributor[0]
  to   = azurerm_role_assignment.constrained_storage_role["Storage Account Contributor"]
}
