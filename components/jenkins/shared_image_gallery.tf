data "azurerm_shared_image_gallery" "imagegallery" {
  provider            = azurerm.image_gallery
  name                = "hmcts"
  resource_group_name = "hmcts-image-gallery-rg"
}
resource "azurerm_role_assignment" "imagegallery" {
  provider             = azurerm.image_gallery
  scope                = data.azurerm_shared_image_gallery.imagegallery.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.usermi.principal_id
}
