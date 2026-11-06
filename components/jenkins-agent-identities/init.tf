terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.13.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.10.0"
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


provider "azurerm" {
  features {}
  alias           = "alerts-slack"
  subscription_id = var.alerts_subscription_id
}
