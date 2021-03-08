terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  skip_provider_registration = true
}

data "azurerm_resource_group" "sandbox" {
  name = var.resource_group_name
}