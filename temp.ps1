param(
    [Parameter(Mandatory = $true)]$NamePrefix,
    [Parameter(Mandatory = $true)]$PlaybookName,
    [Parameter(Mandatory = $true)]$ResourceGroup,
    [Parameter(Mandatory = $true)]$Location
)

$DeployedName = $NamePrefix + ".$PlaybookName"


# get the object id of the playbook
$ID = (Get-AzResource -Name $DeployedName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId
$MIGuid = $ID
$MI = Get-AzureADServicePrincipal -ObjectId $MIGuid


# Deploy all of these playbooks without downloading or cloning this repository
$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"


# remote deploys
$deploymentName = $PlaybookName + $deploySuffix


$remoteUrl = ""
$remoteTemplate = ""
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $remoteTemplate `
    -Verbose
