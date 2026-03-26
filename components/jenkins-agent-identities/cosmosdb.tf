data "azurerm_cosmosdb_account" "pipeline_metrics" {
  provider = azurerm.cosmosdb

  name                = var.env == "sbox" || var.env == "ptlsbox" ? "sandbox-pipeline-metrics" : "pipeline-metrics"
  resource_group_name = var.env == "sbox" || var.env == "ptlsbox" ? "pipelinemetrics-database-sandbox" : "pipelinemetrics-database-prod"
}

resource "azurerm_cosmosdb_sql_role_assignment" "cosmosdb_data_contributor" {
  provider = azurerm.cosmosdb

  resource_group_name = data.azurerm_cosmosdb_account.pipeline_metrics.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.pipeline_metrics.name
  # Cosmos DB Built-in Data Contributor
  role_definition_id = "${data.azurerm_cosmosdb_account.pipeline_metrics.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id       = local.principal_id
  scope              = data.azurerm_cosmosdb_account.pipeline_metrics.id
}
