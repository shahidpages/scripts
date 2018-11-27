#Login to Azure
login-azurermaccount

#Select Sub
Select-AzureRmSubscription -SubscriptionName "pay-as-you-go"

#Variables
$RG = "MyCompanyRG"
$Location = "East US"
$AppSP = "MyCompanyAppSP"
$WebApp = "MyCompanyAppSB"
$WebApp2 = "MyCompanyAppSB2"

#Create Resource Group
New-AzureRmResourceGroup -name $RG -location $Location

#Create App Service Plan
New-AzureRmAppServicePlan -Name $AppSP -Location $Location -ResourceGroupName $RG -Tier Premium -WorkerSize Large -NumberofWorkers 10

#View Details of a Service Plan
Get-AzureRmAppServicePlan -Name $AppSP

#Change an existing Service Plan
Set-AzureRmAppServicePlan -Name $AppSP -ResourceGroupName $RG -Tier Standard -WorkerSize Medium -NumberofWorkers 9

#View Details of a Service Plan
Get-AzureRmAppServicePlan -Name $AppSP

#Create a Web App
New-AzureRmWebApp -Name $WebApp -AppServicePlan $AppSP -ResourceGroupName $RG -Location $Location

#Create a Web App
New-AzureRmWebApp -Name $WebApp2 -AppServicePlan $AppSP -ResourceGroupName $RG -Location $Location

#Get Web App
Get-AzureRMWebApp -ResourceGroupName $RG 


#Restart a Web App
Stop-AzureRmWebapp -Name $WebApp -ResourceGroupName $RG


