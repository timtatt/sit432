terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.46.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.1"
    }
    external = {
      source = "hashicorp/external"
      version = "~> 2.1"
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