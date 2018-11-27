#Login
Login-AzureRmAccount

#Retrieve App Creds
$creds = Get-Credential

#Select the subscription
$tenant = (Get-AzureRmSubscription -SubscriptionName "{subscriptionname").TenantId

#Add the App
Add-AzureRmAccount -Credential $creds -ServicePrincipal -TenantId $tenant

#Save as a JSON file if necessary
Save-AzureRmProfile -Path "{path}\SPlogin.json"