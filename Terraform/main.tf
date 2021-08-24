terraform {

  required_providers {
    azurerm = "~> 2.65"
  }

  required_version = ">= 0.14.9"

}



provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "main" {
  name                     = "seanterraformstorageaccount"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_application_insights" "main" {
  name                = "sean-terraform-functionapp"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  application_type    = "web"
}

resource "azurerm_app_service_plan" "main" {
  name                = "sean-terraform-appserviceplan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "main" {
  name                      = "sean-terraform-functionapp"
  resource_group_name       = azurerm_resource_group.main.name
  location                  = azurerm_resource_group.main.location
  app_service_plan_id       = azurerm_app_service_plan.main.id
  storage_connection_string = azurerm_storage_account.main.primary_connection_string

  app_settings = {
    AppInsights_InstrumentationKey = azurerm_application_insights.main.instrumentation_key
  }
  
  identity {
    type = "SystemAssigned"   
  }
}