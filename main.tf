resource "azurerm_resource_group" "rg" {
    name = var.azure_resource_group
    location = "westus"

    lifecycle {
        prevent_destroy = true
    }
}

resource "azurerm_storage_account" "storageaccount" {
    name = var.azure_storage_account
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_kind = "StorageV2"
    account_tier = "Standard"
    account_replication_type = "LRS"

    lifecycle {
        prevent_destroy = true
    }
}

resource "azurerm_storage_container" "storagecontainer" {
    name = var.azure_storage_container
    storage_account_name = azurerm_storage_account.storageaccount.name
    container_access_type = "private"

    lifecycle {
        prevent_destroy = true
    }
}

resource "azurerm_storage_blob" "storagefile" {
    name = var.azure_storage_blob
    storage_account_name = azurerm_storage_account.storageaccount.name
    storage_container_name = azurerm_storage_container.storagecontainer.name
    type = "Block"
    source = var.azure_storage_blob
}
