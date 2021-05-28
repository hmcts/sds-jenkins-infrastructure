variable "environment" {
  description = "Name of the environment to deploy the resource."
  type        = string
}
variable "product" {
  description = "Name of the product."
  type        = string
}

variable "location" {
  description = "Azure location to deploy the resource"
  type        = string
  default     = "UK South"
}

variable "builtFrom" {
  description = "Name of the GitHub repository this application is being built from."
  type        = string
}
variable "database" {
  description = "Name of the cosmos database."
  default     = "jenkins"
}
variable "max_throughput" {
  default     = "4000"
  description = "The Maximum throughput of SQL database (RU/s)."
}
variable "parition_key" {
  type        = map(any)
  description = "Partition Keys for corresponding databases."
  default = {
    cve-reports         = "/build/git_url"
    performance-metrics = "/_partitionKey"
    pipeline-metrics    = "/_partitionKey"
  }
}
variable "mi_roles" {
  description = "Roles assigned to managed identity"
  default     = ["Contributor", "User Access Administrator"]
}
variable "subscription_id" {
  description = "Name of the Subscription."
}

variable "azure_keyvault" {
  description = "Name of the Azure KeyVault to store cosmosdb keys & disk details."
}
variable "azure_keyvault_rg" {
  description = "Name of the Azure KeyVault resource group."
  default     = "sds-platform-sbox-rg"
}