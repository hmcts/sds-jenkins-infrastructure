terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.61.0"
    }
  }
  required_version = ">=1.0.0"
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}