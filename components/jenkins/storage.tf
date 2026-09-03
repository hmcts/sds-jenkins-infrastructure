resource "azurerm_storage_account" "jenkinsstg" {
  name                     = "mgmtstatestore"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = module.tags.common_tags
}

resource "azurerm_storage_container" "example" {
  name                  = "mgmtstatestorecontainer"
  storage_account_name  = azurerm_storage_account.jenkinsstg.name
  container_access_type = "private"
}