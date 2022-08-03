param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)
# Deploy all of these playbooks without downloading or cloning this repository
$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"

# remote deploys
$deploymentName = "" + $deploySuffix
$remoteUrl = ""
$remoteTemplate = ''
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $remoteTemplate `
    -Verbose
