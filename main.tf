terraform {
  backend "azurerm" {
    resource_group_name  = "rg-shared-mgmt-francecentral-001"
    storage_account_name = "stmgmtfcngd001"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      version = "~>3.2"
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" { 
    environment = "public"
    version = ">= 2.0.0"
    tenant_id       = "aec7905c-5311-4d4e-a8ee-b18f05f776f9"
    subscription_id = "79140c7f-41cc-4861-9bfa-d7f2bc46d5c9"
    client_id       = "9c2b33ce-5466-477d-b720-fe69089cc47b"
    client_secret   = "nyY8Q~vBx.05dSEg.hqg7nrMxCfxwb3hUCmA5aSp"
    features {}  
}

resource "azurerm_resource_group" "rg" {
    location = "France Central"
    name     = "rg-test-github-actions"
}