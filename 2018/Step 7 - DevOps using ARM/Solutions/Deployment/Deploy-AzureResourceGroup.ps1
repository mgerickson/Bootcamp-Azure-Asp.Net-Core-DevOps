#Powershell script to use locally as example. Let's adapt it for your own needs.

Param(
    [string] $ResourceGroupLocation = 'East US',
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $TemplateFile = 'azuredeploy.json'
)

#Login-AzureRmAccount;
#Select-AzureRmSubscription -SubscriptionId $SubscriptionId;
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation;
New-AzureRmResourceGroupDeployment -Name ($ResourceGroupName  + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')) `
                                        -ResourceGroupName $ResourceGroupName `
                                        -TemplateFile $TemplateFile `
									                      -Force -Verbose;