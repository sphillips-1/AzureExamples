terraform {
  required_version = ">= 1.1.9"
  backend "azurerm" {}
  required_providers {
    azurerm = "3.4.0"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

variable "subnet_id" { type = string }
variable "environment" { type = string }

locals {
  resourceGroupName = join("",["rg-ProjectName-", var.environment])
  containerName = join("", ["ci-ProjectName-", var.environment])
}

resource "azurerm_resource_group" "main" {

  name     = local.resourceGroupName 
  location = "eastus"
  tags     = local.common_tags

}

resource "azurerm_network_profile" "main" {
  name                = local.networkProfile
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  container_network_interface {
    name = "containernic"

    ip_configuration {
      name      = "vnet-east"
      subnet_id = var.subnet_id
    }
  }
}


resource "azurerm_container_group" "main" {
  name                = local.containerGroupName
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_address_type     = "Private"
  os_type             = "Linux"

  network_profile_id = azurerm_network_profile.main.id

  image_registry_credential {
    username = ""
    password = ""
    server = "XXXXXXXXXXXX.azurecr.io"
  }

  container {
    name   = ""
    image  =  "XXXXXXXXXXXX.azurecr.io/XXXXXXXXXXX:latest" 
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {}

  }
}
