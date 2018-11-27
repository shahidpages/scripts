#Create New RG
New-AzureRmResourceGroup -Name ABCCompany -Location eastus

#New Vnet
New-AzureRmVirtualNetwork -ResourceGroupName ABCCompany -Name CompanyVnet -AddressPrefix 10.4.0.0/24 -Location eastus

 
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName ABCCompany -Name CompanyVnet 

Add-AzureRmVirtualNetworkSubnetConfig -Name testdev -VirtualNetwork $vnet -AddressPrefix 10.4.0.0/24
 


 
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
 