resource "azurerm_resource_group" "rg" {
    name = "PBI2ADLS"
    location = "westus"
}

resource "azurerm_storage_account" "storageacc" {
    name = "pbi2adlsstorage"
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
    name = "ws1intel"
    storage_account_name = azurerm_storage_account.storageacc.name
    container_access_type = "private"

    lifecycle {
        prevent_destroy = true
    }
}

resource "azurerm_storage_blob" "storagefile" {
    name = "ws1intelreport.csv"
    storage_account_name = azurerm_storage_account.storageacc.name
    storage_container_name = azurerm_storage_container.storagecontainer.name
    type = "Block"
    source = "ws1intelreport.csv"
}
