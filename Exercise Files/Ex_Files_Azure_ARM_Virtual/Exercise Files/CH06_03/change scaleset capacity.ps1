#login
Login-AzureRmAccount

#Variables
$RGName = "ProductionVMSS"
$VMSSName = "proddata"

#View ScaleSet
Get-AzureRmVmss -ResourceGroupName $RGName -VMScaleSetName $VMSSName


#Change the capacity

$vmss = Get-AzureRmVmss -ResourceGroupName $RGName -VMScaleSetName $VMSSName
$vmss.sku.capacity = 3
Update-AzureRmVmss -ResourceGroupName $RGName -Name $VMSSName -VirtualMachineScaleSet $vmss 
