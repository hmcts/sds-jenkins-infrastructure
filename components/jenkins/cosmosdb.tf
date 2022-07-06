locals {
  suffix = var.env == "ptlsbox" ? "-sbox" : ""
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                      = "${var.product}-pipeline-metrics${local.suffix}"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  tags                      = module.tags.common_tags
  enable_automatic_failover = true
  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = "UK West"
    failover_priority = 0
  }

  geo_location {
    location          = var.location
    failover_priority = 1
    zone_redundant    = true
  }
}


resource "azurerm_cosmosdb_sql_database" "sqlapidb" {
  name                = var.database
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  autoscale_settings {
    max_throughput = var.max_throughput
  }
}


resource "azurerm_cosmosdb_sql_container" "container" {
  for_each              = var.partition_key
  name                  = each.key
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.cosmosdb.name
  database_name         = azurerm_cosmosdb_sql_database.sqlapidb.name
  partition_key_path    = each.value
  partition_key_version = 2
  autoscale_settings {
    max_throughput = var.max_throughput
  }

  indexing_policy {
    indexing_mode = "Consistent"
  }

}

resource "azurerm_cosmosdb_sql_role_assignment" "this" {
  resource_group_name = azurerm_cosmosdb_account.cosmosdb.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  # Cosmos DB Built-in Data Contributor
  role_definition_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/{var.resource_group_name}/providers/Microsoft.DocumentDB/databaseAccounts/${azurerm_cosmosdb_account.cosmosdb.name}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id       = azurerm_user_assigned_identity.usermi.principal_id
  scope              = "/"
}
