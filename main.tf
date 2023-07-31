# Define Terraform provider
terraform {
  required_version = ">= 1.3"
  backend "azurerm" {
    resource_group_name  = "rg-shared-mgmt-francecentral-001"
    storage_account_name = "stmgmtfcngd001"
    container_name       = "tfstate"
    key                  = "actions.tfstate"
  }
  required_providers {
    azurerm = {
      version = "~>3.2"
      source  = "hashicorp/azurerm"
    }
  }
}
# Configure the Azure provider
provider "azurerm" { 
  features {}  
}

resource "azurerm_resource_group" "rg" {
    location = "France Central"
    name     = "rg-test-github-actions"
}