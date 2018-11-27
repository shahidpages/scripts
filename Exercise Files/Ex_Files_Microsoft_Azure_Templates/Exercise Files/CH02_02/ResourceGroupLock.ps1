#Login 
Login-AzureRmAccount

#Select correct subscription if necessary
Select-AzureRmSubscription -SubscriptionId {SubscriptionID} 

#Apply the lock 
New-AzureRmResourceLock -LockLevel CanNotDelete -LockName Storagelock -ResourceName simplevmdisks607 -ResourceType Microsoft.Storage/storageAccounts -ResourceGroupName SimpleVM