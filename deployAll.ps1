# deploy all playbooks to sentinel

param(
    [Parameter(Mandatory = $true)]$ResourceGroup,
)

# new playbook name = $namePrefix + "." + $playbookName
# Need to figure out how to insert this into the parameter file when before deploying

# deployments must each have a unique name
$suffix = Get-Random -Maximum 1000
$deploymentName = "ExampleDeployment" + $suffix

# Playbook relative locations
$EnrichEmail = 'Enrich-email-plus\azuredeploy.json'
$EnrichEmailParams = ''

$GetGeoIP = 'Get-GEOIPdata-tagIncident\azuredeploy.json'
$GetGeoIPParams = ''

$NewIncidentEmail = 'Send-email-with-formatted-incident-report\azuredeploy.json'
$NewIncidentEmailParams = ''

$FullInvestgation = 'Start-CompleteMDEInvestigation\azuredeploy.json'
$FullInvestgationParams = ''

$VTEnrichAllEntities = 'VirusTotalEnrichAllEntites\azuredeploy.json'
$VTEnrichAllEntitiesParams = ''
# End Playbook relative locations

$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"

# remote deploys
$deploymentName = "Enrich-email-plus" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Enrich-email-plus/azuredeploy.json"
$yourParameters = ''
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $yourParameters


"https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Get-GEOIPdata-tagIncident/azuredeploy.json"

"https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Send-email-with-formatted-incident-report/azuredeploy.json"

"https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Start-CompleteMDEInvestigation/azuredeploy.json"

"https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/VirusTotalEnrichAllEntites/azuredeploy.json"