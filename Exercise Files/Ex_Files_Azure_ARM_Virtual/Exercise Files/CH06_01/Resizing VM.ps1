Login-AzureRmAccount

$ResourceGroupName = "Production"
$VMName = "Prod1"
$NewVMSize = "Standard_A2"
 
$vm = Get-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VMName
$vm.HardwareProfile.vmSize = $NewVMSize
Update-AzureRmVM -ResourceGroupName $ResourceGroupName -VM $vm