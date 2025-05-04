provider "azurerm" {
  features {}
  subscription_id = "2e2b7ea8-71a7-4e33-a116-85989b5dc3b4"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "ashishlavale5tfstates"
  resource_group_name      = "Project-Setup"
  location                 = "UK West"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "tfstates" {
  name                  = "roboshop-state-files"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

