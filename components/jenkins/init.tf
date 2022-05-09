terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
    }
  }
  required_version = ">=1.0.0"
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = "2b1afc19-5ca9-4796-a56f-574a58670244"
  alias                      = "image_gallery"
  features {}
}

provider "azurerm" {
  subscription_id = var.private_dns_subscription_id
  alias           = "private_dns"
  features {}
}

provider "azurerm" {
  subscription_id = "8999dec3-0104-4a27-94ee-6588559729d1"
  alias           = "acr"
  features {}
}