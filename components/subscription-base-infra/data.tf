data "azurerm_key_vault" "jenkinskv" {
  name = "ptl"
  resource_group_name = "sds-jenkins-ptl-rg"
}