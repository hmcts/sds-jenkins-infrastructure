data "azurerm_shared_image_gallery" "imagegallery" {
  provider            = azurerm.image_gallery
  name                = "cnpimagegallery"
  resource_group_name = "cnp-image-gallery-rg"
}
resource "azurerm_role_assignment" "imagegallery" {
  provider             = azurerm.image_gallery
  scope                = data.azurerm_shared_image_gallery.imagegallery.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}