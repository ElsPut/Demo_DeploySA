param mysaname string 

resource sa 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: mysaname
}

resource mysablobservice 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' existing = {
  name: 'default'
  parent: sa
}

resource myblob 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: 'mycontainer'
  parent: mysablobservice
}
