terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.68.0"
    }
  }
  required_version = ">=1.0.0"
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  subscription_id = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
  alias           = "image_gallery"
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