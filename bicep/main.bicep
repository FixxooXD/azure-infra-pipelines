targetScope = 'subscription'

param location string = 'southeastasia'
param resourceGroupName string = 'test-biceps-rg'
param storageAccountName string = 'st${uniqueString(subscription().id)}'

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
}

module storage 'storageAccount.bicep' = {
  name: 'storageDeployment'
  scope: rg
  params: {
    location: location
    storageAccountName: storageAccountName
  }
}

output storageAccountId string = storage.outputs.storageAccountId
