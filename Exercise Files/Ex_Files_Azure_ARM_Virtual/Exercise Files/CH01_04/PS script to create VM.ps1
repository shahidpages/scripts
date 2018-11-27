#Global Variables
$rgName = "Production3"
$location = "eastus"

#Storage - storagename must be unique
$storageName = "prodstorsb"
$storageType = "Standard_LRS"

#Network
$nicname = "prodnic"
$subnet1Name = "subnet1"
$vnetName = "prodnet"
$vnetAddressPrefix = "10.0.0.0/16"
$vnetSubnetAddressPrefix = "10.0.0.0/24"

#Compute
$vmName = "prodvm"
$computerName = "prodcomputer"
$vmSize = "Standard_A1"
$osDiskName = $vmName + "osDisk"

#Resource Group

New-AzureRmResourceGroup -Name $rgName -Location $location

#Storage

$storageacc = New-AzureRmStorageAccount -ResourceGroupName $rgName -Name $storageName -Type $storageType -Location $location

#Network

$pubip = New-AzureRmPublicIpAddress -Name $nicname -ResourceGroupName $rgName -Location $location -AllocationMethod Dynamic
$subnetconfig = New-AzureRmVirtualNetworkSubnetConfig -Name $subnet1Name -AddressPrefix $vnetSubnetAddressPrefix
$vnet = New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -Location $location -AddressPrefix $vnetAddressPrefix -Subnet $subnetconfig
$nic = New-AzureRmNetworkInterface -Name $nicname -ResourceGroupName $rgName -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pubip.Id


#Configure VM 
$cred = Get-Credential -Message "Enter the admin username and password"
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $computerName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2012-R2-Datacenter" -Version "latest"
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id

$blobPath = "vhds/OsDisk1.vhd"
$osDiskUri = $storageacc.PrimaryEndpoints.Blob.ToString() + $blobPath

$vm = Set-AzureRmVMOSDisk -VM $vm -Name "OsDisk1" -VhdUri $osDiskUri -CreateOption fromImage

New-AzureRmVM -ResourceGroupName $rgname -Location $location -VM $vm

Get-AzureRmVM -ResourceGroupName $rgName

