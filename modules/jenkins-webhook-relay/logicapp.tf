resource "azurerm_logic_app_workflow" "logic_app_workflow" {
  name                = "github-jenkins-${var.env}"
  enabled             = var.enable_workflow
  location            = var.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name

  identity {
    type = "SystemAssigned"
  }

  tags = module.ctags.common_tags
}

resource "azurerm_resource_group_template_deployment" "logic_app_deployment" {
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  deployment_mode     = "Incremental"
  name                = "logic-app-deployment"

  template_content = data.local_file.logic_app.content

  parameters_content = jsonencode({
    "logic_app_name"  = { value = azurerm_logic_app_workflow.logic_app_workflow.name }
    "location"        = { value = var.location }
    "commonTags"      = { value = base64encode(jsonencode(module.ctags.common_tags)) }
    "subscription_id" = { value = var.subscription_id }
  })

  tags = module.ctags.common_tags
}