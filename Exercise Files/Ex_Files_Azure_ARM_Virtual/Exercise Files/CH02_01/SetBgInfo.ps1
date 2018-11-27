#Login
Login-AzureRmAccount

#list extensions
get-command Set-AzureRM*Extension* -Module AzureRM.Compute

#Set BGInfo
Set-AzureRmVMBginfoExtension -resourcegroup "proddata" -vmname "web2"
