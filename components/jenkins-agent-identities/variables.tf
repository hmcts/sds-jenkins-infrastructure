variable "env" {
  description = "Name of the target SDS environment for this managed identity."
  type        = string
}

variable "builtFrom" {
  description = "Compatibility variable for shared pipeline template."
  type        = string
}

variable "product" {
  description = "Compatibility variable for shared pipeline template."
  type        = string
}

variable "expiresAfter" {
  description = "Expiration date for common tags."
  type        = string
  default     = "3000-01-01"
}

variable "location" {
  description = "Azure location for the managed identity."
  type        = string
  default     = "UK South"
}

variable "subscription_id" {
  description = "Target environment subscription ID for managed identity and subscription-level role assignments."
  type        = string
}

variable "cosmos_subscription_id" {
  description = "Subscription containing cosmos db for pipeline metrics"
  type        = string
}

variable "managed_identity_name" {
  description = "Managed identity name."
  type        = string
}

variable "managed_identity_resource_group_name" {
  description = "Resource group where the managed identity exists or will be created."
  type        = string
}

variable "create_identity" {
  description = "Whether to create the managed identity (true) or reference an existing one (false)."
  type        = bool
  default     = true
}

variable "manage_contributor_role" {
  description = "Whether to manage the Contributor subscription role assignment."
  type        = bool
  default     = true
}

variable "manage_aks_cluster_admin_role" {
  description = "Whether to manage the AKS Cluster Admin subscription role assignment."
  type        = bool
  default     = true
}

variable "private_dns_subscription_id" {
  description = "Subscription ID that hosts the shared private DNS zones."
  type        = string
}

variable "private_dns_resource_group_name" {
  description = "Resource group containing the shared private DNS zones."
  type        = string
}

variable "tags" {
  description = "Optional tags to apply when creating the managed identity."
  type        = map(string)
  default     = {}
}

variable "key_vaults" {
  description = "Map of key vaults to which the managed identity should be granted access, keyed by an arbitrary name. Each value should be an object with 'name' and 'resource_group_name' properties."
  type = map(object({
    name                = string
    resource_group_name = string
  }))
  default = {}
}