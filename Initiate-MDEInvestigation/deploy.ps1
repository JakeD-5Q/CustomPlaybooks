param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)

# Deploy all of these playbooks without downloading or cloning this repository
$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"

# remote deploys
$deploymentName = "Initiate-MDEInvestigation" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/CustomPlaybooks/main/Initiate-MDEInvestigation/azuredeploy.json"
$localTemplate = 'enter.local.file.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate `
    -Verbose