provider "azurerm" {
  features {}
  subscription_id = "2e2b7ea8-71a7-4e33-a116-85989b5dc3b4"
}

terraform {
  backend "azurerm" {
    subscription_id      = "2e2b7ea8-71a7-4e33-a116-85989b5dc3b4"
    resource_group_name  = "project-setup-1"
    storage_account_name = "ashishlavale5tfstates"
    container_name       = "roboshop-state-files"
    key                  = "tools.terraform.tfstate"

  }
}

