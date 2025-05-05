provider "vault" {
  address = "http://vault.rdevopsb84.online:8200"
  token   = var.token
}



terraform {
  backend "azurerm" {
    use_cli              = true
    subscription_id      = "323379f3-3beb-4865-821e-0fff68e4d4ca"
    resource_group_name  = "project-setup-1"
    storage_account_name = "rdevopsb84tfstates"
    container_name       = "roboshop-state-files"
    key                  = "vault.terraform.tfstate"
  }
}


