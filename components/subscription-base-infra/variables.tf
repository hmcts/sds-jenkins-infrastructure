variable "env" {
  description = "Name of the environment to deploy the resource."
  type        = string
}
variable "product" {
  description = "Name of the product."
  type        = string
}

variable "builtFrom" {
  description = "Name of the GitHub repository this application is being built from."
  type        = string
}

variable "location" {
  description = "Azure location to deploy the resource"
  type        = string
  default     = "UK South"
}

variable "jenkins_identity_object_id" {
  description = "Objectid for jenkins managed identity"
  default     = "7ef3b6ce-3974-41ab-8512-c3ef4bb8ae01"
}

variable "env_subscription_id" {}