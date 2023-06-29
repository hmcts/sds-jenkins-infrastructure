variable "subscription_id" {
  description = "Enter Azure subscription id."
}

variable "location" {
  description = "Enter Azure location."

}

variable "env" {
  description = "Enter the environment. eg prod, aat"
}

variable "product" {
  description = "The name of the product."
}

variable "builtFrom" {
  description = "The name of the Github repo."
}

variable "expiresAfter" {
  description = "Expiration date"
}

variable "project" {
  description = "The name of the project."
}
variable "servicebus_enable_private_endpoint" {
  description = "Enable private endpoint."

}
variable "queue_name" {

  description = "Name of the servicebus Queue."
}
variable "key_vault_name" {
  description = "Name of the keyvault in CFT to storage secrets"
}
variable "key_vault_rg_name" {
  description = "Name of the keyvault resource group in CFT."
}
variable "zone_redundant" {
  description = "Enable Zone redundancy."

}
variable "enable_workflow" {
  description = "Enable workflow"

}

