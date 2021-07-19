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

variable "jenkins-ptlsbox-mi" {
  description = "Objectid of the jenkins managed identity"
  type        = string
  default     = "6df94cb5-c203-4493-bc8a-3f6aad1133e1"
}

variable "jenkins-ptl-mi" {
  description = "Objectid of the jenkins managed identity"
  type        = string
  default     = "7ef3b6ce-3974-41ab-8512-c3ef4bb8ae01"
}
