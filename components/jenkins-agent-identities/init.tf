terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.9.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}
  alias                           = "private_dns"
  subscription_id                 = var.private_dns_subscription_id
  resource_provider_registrations = "none"
}

provider "azurerm" {
  features {}
  alias                           = "cosmosdb"
  subscription_id                 = var.cosmos_subscription_id
  resource_provider_registrations = "none"
}
