locals {
  suffix = var.env == "ptlsbox" ? "-sbox" : ""
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                       = "${var.product}-pipeline-metrics${local.suffix}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  offer_type                 = "Standard"
  kind                       = "GlobalDocumentDB"
  tags                       = local.common_tags
  automatic_failover_enabled = true
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
  partition_key_paths   = [each.value]
  partition_key_version = 2
  autoscale_settings {
    max_throughput = var.max_throughput
  }

  indexing_policy {
    indexing_mode = "consistent"
    included_path {
      path = "/*"
    }
  }

}

resource "azurerm_cosmosdb_sql_role_assignment" "this" {
  resource_group_name = azurerm_cosmosdb_account.cosmosdb.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  # Cosmos DB Built-in Data Contributor
  role_definition_id = "${azurerm_cosmosdb_account.cosmosdb.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id       = azurerm_user_assigned_identity.usermi.principal_id
  scope              = azurerm_cosmosdb_account.cosmosdb.id
}
