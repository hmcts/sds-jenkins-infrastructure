data "azuread_group" "directory_readers" {
  display_name     = "DTS Directory Readers"
  security_enabled = true
}
