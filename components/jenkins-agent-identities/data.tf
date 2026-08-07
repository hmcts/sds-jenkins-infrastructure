data "azuread_group" "directory_readers" {
  count            = var.create_identity ? 1 : 0
  display_name     = "DTS Directory Readers"
  security_enabled = true
}
