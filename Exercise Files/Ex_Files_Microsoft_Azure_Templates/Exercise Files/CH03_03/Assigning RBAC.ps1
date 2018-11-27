#login
Login-AzureRMAccount

#switch subscriptions if necessary
Select-Subscription {subscriptionid} 

#List All Roles
Get-AzureRmRoleDefinition | FT Name, Description

#List what the role can not do
Get-AzureRmRoleDefinition Contributor | FL Actions, NotActions

#List role assignment
Get-AzureRmRoleAssignment -ResourceGroupName {resourcegroupname} | FL DisplayName, RoleDefinitionName, Scope

#Assign a user at the RG
New-AzureRmRoleAssignment -SignInName user@yourcompany.com -RoleDefinitionName "contributor" -ResourceGroupName {resourcegroupname}

#List Role Assignments in a RG
Get-AzureRMRoleAssignment -ResourceGroupName {resourcegroupname}

