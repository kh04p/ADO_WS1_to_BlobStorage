[CmdletBinding()] # Vars from pipeline YAML file
param (
    $resourceGroupName,
    $storageAccountName,
    $containerName,
    $filePath
)
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName)[0].Value
$storageAccount = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey -Protocol Https
$fileName = $filePath.Replace("/home/vsts/work/_temp/","")
Set-AzStorageBlobContent -File $filePath -Container $containerName -Blob $fileName -Force -Context $storageAccount -Properties @{"ContentType" = "file/download"}
