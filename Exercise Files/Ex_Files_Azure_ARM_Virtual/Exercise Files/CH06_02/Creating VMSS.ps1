 #https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-windows-create
 
 Get-AzureLocation | Sort Name | Select Name
 $locName = "location name from the list, such as Central US"
 $rgName = "resource group name"
 New-AzureRmResourceGroup -Name $rgName -Location $locName
 
 $saName = "storage account name"
 Get-AzureRmStorageAccountNameAvailability $saName
 New-AzureRmStorageAccount -Name $saName -ResourceGroupName $rgName –Type $saType -Location $locName
 
 $subnetName = "subnet name"
 $subnet = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix 10.0.0.0/24
 $netName = "virtual network name"
 $vnet = New-AzureRmVirtualNetwork -Name $netName -ResourceGroupName $rgName -Location $locName -AddressPrefix 10.0.0.0/16 -Subnet $subnet
 
 $ipName = "IP configuration name"
 $ipConfig = New-AzureRmVmssIpConfig -Name $ipName -LoadBalancerBackendAddressPoolsId $null -SubnetId $vnet.Subnets[0].Id
 
 $vmssConfig = "Scale set configuration name"
 Add-AzureRmVmssNetworkInterfaceConfiguration -VirtualMachineScaleSet $vmss -Name $vmssConfig -Primary $true -IPConfiguration $ipConfig
 $computerName = "computer name prefix"
 $adminName = "administrator account name"
 $adminPassword = "password for administrator accounts"
 Set-AzureRmVmssOsProfile -VirtualMachineScaleSet $vmss -ComputerNamePrefix $computerName -AdminUsername $adminName -AdminPassword $adminPassword
 
 $storageProfile = "storage profile name"
 $imagePublisher = "MicrosoftWindowsServer"
 $imageOffer = "WindowsServer"
 $imageSku = "2012-R2-Datacenter"
 $vhdContainers = @("https://myst1.blob.core.windows.net/vhds","https://myst2.blob.core.windows.net/vhds","https://myst3.blob.core.windows.net/vhds")
 Set-AzureRmVmssStorageProfile -VirtualMachineScaleSet $vmss -ImageReferencePublisher $imagePublisher -ImageReferenceOffer $imageOffer -ImageReferenceSku $imageSku -ImageReferenceVersion "latest" -Name $storageProfile -VhdContainer $vhdContainers -OsDiskCreateOption "FromImage" -OsDiskCaching "None"  
 
 $vmssName = "scale set name"
 New-AzureRmVmss -ResourceGroupName $rgName -Name $vmssName -VirtualMachineScaleSet $vmss
