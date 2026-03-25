module "tags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}

locals {
  common_tags = merge(module.tags.common_tags, var.tags)
}

resource "azurerm_user_assigned_identity" "this" {
  count = var.create_identity ? 1 : 0

  name                = var.managed_identity_name
  location            = var.location
  resource_group_name = var.managed_identity_resource_group_name
  tags                = local.common_tags
}

data "azurerm_user_assigned_identity" "existing" {
  count = var.create_identity ? 0 : 1

  name                = var.managed_identity_name
  resource_group_name = var.managed_identity_resource_group_name
}

locals {
  principal_id = var.create_identity ? azurerm_user_assigned_identity.this[0].principal_id : data.azurerm_user_assigned_identity.existing[0].principal_id

  contributor_assignment_name = format(
    "%s-%s-%s-%s-%s",
    substr(md5("Contributor:/subscriptions/${var.subscription_id}:${local.principal_id}"), 0, 8),
    substr(md5("Contributor:/subscriptions/${var.subscription_id}:${local.principal_id}"), 8, 4),
    substr(md5("Contributor:/subscriptions/${var.subscription_id}:${local.principal_id}"), 12, 4),
    substr(md5("Contributor:/subscriptions/${var.subscription_id}:${local.principal_id}"), 16, 4),
    substr(md5("Contributor:/subscriptions/${var.subscription_id}:${local.principal_id}"), 20, 12)
  )

  aks_admin_assignment_name = format(
    "%s-%s-%s-%s-%s",
    substr(md5("Azure Kubernetes Service Cluster Admin Role:/subscriptions/${var.subscription_id}:${local.principal_id}"), 0, 8),
    substr(md5("Azure Kubernetes Service Cluster Admin Role:/subscriptions/${var.subscription_id}:${local.principal_id}"), 8, 4),
    substr(md5("Azure Kubernetes Service Cluster Admin Role:/subscriptions/${var.subscription_id}:${local.principal_id}"), 12, 4),
    substr(md5("Azure Kubernetes Service Cluster Admin Role:/subscriptions/${var.subscription_id}:${local.principal_id}"), 16, 4),
    substr(md5("Azure Kubernetes Service Cluster Admin Role:/subscriptions/${var.subscription_id}:${local.principal_id}"), 20, 12)
  )

  private_dns_assignment_name = format(
    "%s-%s-%s-%s-%s",
    substr(md5("Private DNS Zone Contributor:/subscriptions/${var.private_dns_subscription_id}/resourceGroups/${var.private_dns_resource_group_name}:${local.principal_id}"), 0, 8),
    substr(md5("Private DNS Zone Contributor:/subscriptions/${var.private_dns_subscription_id}/resourceGroups/${var.private_dns_resource_group_name}:${local.principal_id}"), 8, 4),
    substr(md5("Private DNS Zone Contributor:/subscriptions/${var.private_dns_subscription_id}/resourceGroups/${var.private_dns_resource_group_name}:${local.principal_id}"), 12, 4),
    substr(md5("Private DNS Zone Contributor:/subscriptions/${var.private_dns_subscription_id}/resourceGroups/${var.private_dns_resource_group_name}:${local.principal_id}"), 16, 4),
    substr(md5("Private DNS Zone Contributor:/subscriptions/${var.private_dns_subscription_id}/resourceGroups/${var.private_dns_resource_group_name}:${local.principal_id}"), 20, 12)
  )
}

resource "azurerm_role_assignment" "contributor" {
  count = var.manage_contributor_role ? 1 : 0

  scope                = "/subscriptions/${var.subscription_id}"
  name                 = local.contributor_assignment_name
  role_definition_name = "Contributor"
  principal_id         = local.principal_id
}

resource "azurerm_role_assignment" "aks_cluster_admin" {
  count = var.manage_aks_cluster_admin_role ? 1 : 0

  scope                = "/subscriptions/${var.subscription_id}"
  name                 = local.aks_admin_assignment_name
  role_definition_name = "Azure Kubernetes Service Cluster Admin Role"
  principal_id         = local.principal_id
}

resource "azurerm_role_assignment" "private_dns_zone_contributor" {
  provider = azurerm.private_dns

  scope                = "/subscriptions/${var.private_dns_subscription_id}/resourceGroups/${var.private_dns_resource_group_name}"
  name                 = local.private_dns_assignment_name
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = local.principal_id
}
