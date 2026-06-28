terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" # Specifies the source for the Azure provider plugin.
      version = "~>2.0"            # Ensures the Azure provider plugin version is 2.x.x (compatible with this configuration).
    }
  }
}

provider "azurerm" {
  features {}                        # Required for newer versions of the Azure provider, initializes provider features.

  subscription_id   = "294fc8e5-3491-4a9e-8db3-78b02fd829e3" # Your Azure subscription ID.
  tenant_id         = "91ea826a-20e0-408f-995f-122365df91f9" # Your Azure Active Directory (AAD) tenant ID.
  client_id         = "fe7658fa-b040-43a5-b379-61ceb90ca8cf" # The client ID of the service principal for authentication.
  client_secret     = "NhC8Q~rqlvxAsfymC6royDxKeyMZn4TaNNivIcDd" # The client secret of the service principal.
}

resource "azurerm_resource_group" "jafar" {
  name     = "Jafar_RG2"   # Resource group name
  location = "WestUS2"           # Azure region
}

resource "azurerm_storage_account" "example" {
  name                     = "jafarstrogaeterrafrom"
  resource_group_name      = azurerm_resource_group.jafar.name
  location                 = azurerm_resource_group.jafar.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
   environment = "staging"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "jafardata"
  storage_account_name    = azurerm_storage_account.example.name
  container_access_type = "private"

  tags = {
   environment = "datadep"
  }
}

resource "azurerm_storage_container" "fin" {
  name                  = "jafarfin"
  storage_account_name    = azurerm_storage_account.example.name
  container_access_type = "private"

  tags = {
   environment = "Finance"
  }
}
