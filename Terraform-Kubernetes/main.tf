terraform {

  required_providers {
    azurerm = "2.73.0"
  }

  required_version = ">= 0.12.31"

}



provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "AzureKubernetes"
  location = "eastus2"

}

resource "azurerm_container_registry" "main" {
  sku = "Basic"
  name = "SeanACR"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "SeanAKC"
  location            = azurerm_resource_group.main.location
  kubernetes_version  = "1.13.4"
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "SeanAKC"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }
}