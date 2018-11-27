#Log in
login-AzureRMaccount

#Select subscription if necesssary
Select-AzureRmSubscription -SubscriptionId {SubscriptionID}
#Creates a new Policy Definition
New-AzureRmPolicyDefinition -Name RestrictVMs -Description "Restrict VM Sizes" -Policy '{path}\RestrictVMpolicy.json'

#Creates the policy variable
$policy = Get-AzureRmPolicyDefinition -Name RestrictVMs

#Assigns the Policy to Resource Group
New-AzureRmPolicyAssignment -Name RestrictVMs -PolicyDefinition $policy -Scope /subscriptions/{SubscriptionID}/resourcegroups/{resource-group-ame}

#Delete Policy Assignment
Remove-AzureRmPolicyAssignment -Name RestrictVMs -Scope /subscriptions/{SubscriptionId}/resourceGroups/{resource-group-name}


