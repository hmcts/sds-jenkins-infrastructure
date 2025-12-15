variable "env" {
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

variable "private_dns_subscription_id" {}

variable "servicebus_enable_private_endpoint" {
  description = "Enable private endpoint."
  default     = true
}
variable "queue_name" {
  default     = "jenkins"
  description = "Name of the servicebus Queue."
}
variable "zone_redundant" {
  description = "Enable Zone redundancy."
  default     = false
}
variable "enable_workflow" {
  description = "Enable workflow"
  default     = true
}
variable "expiresAfter" {
  description = "Expiration date"
  default     = "3000-01-01"
}

variable "subscription_id" {
  description = "Subscription to run against"
  type        = string
}