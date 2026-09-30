resource "azuread_group_member" "jenkins" {
  count            = var.create_identity ? 1 : 0
  group_object_id  = data.azuread_group.directory_readers[0].object_id
  member_object_id = azurerm_user_assigned_identity.this[count.index].principal_id
}

resource "azuread_group_member" "jenkins_aks_admin" {
  count            = var.manage_aks_administrators_group ? 1 : 0
  group_object_id  = data.azuread_group.aks_administrators[0].object_id
  member_object_id = local.principal_id
}
