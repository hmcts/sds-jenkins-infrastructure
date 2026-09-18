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

  additional_role_guids = {
    for name, def in data.azurerm_role_definition.additional_role :
    name => element(split("/", def.id), length(split("/", def.id)) - 1)
  }
}
