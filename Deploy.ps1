Connect-AzAccount

$rg = New-AzResourceGroup -Name RG52 -Location WestEurope

# CLI - Create service principal to access Azure
az login
az ad sp create-for-rbac --name "sptest1" --role contributor --scopes /subscriptions/a39a4f77-4c6c-42b3-a9a1-1f96a9842799 --sdk-auth 

# PS - Create service principal to access Azure
$sp = New-AzADServicePrincipal -DisplayName RG50testsp2 -Role Contributor -scope $rg.ResourceId
az ad sp create-for-rbac --name "sptest1" --role contributor --scopes /subscriptions/f2214158-e53d-4a65-abc0-9faccc3b3127 --sdk-auth

# PS - Generate sp details to create secret in GitHub
$output = @{
    clientId = $($sp.AppId)
    clientSecret = $sp.PasswordCredentials.secretText
    subscriptionId = $($Context.Subscription.Id)
    tenantId = $($Context.Tenant.Id)
    }
$output | ConvertTo-Json

# Create GitHub secret: AZURE_CREDENTIALS

# Define workflow variable: AZURE_RG_NAME, provide name of your resource group