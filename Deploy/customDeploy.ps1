param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)

$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"

# remote deploys
$deploymentName = "Enrich-Comment-EmailDetails" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Enrich-Comment-EmailDetails/azuredeploy.json"
$localTemplate = 'Enrich-Comment-EmailDetails.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate


$deploymentName = "Enrich-Comment-VirustotalStats" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Enrich-Comment-VirustotalStats/azuredeploy.json"
$localTemplate = 'Enrich-Comment-VirustotalStats.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate

Write-Warning "Must create VirusTotal API connection with new API key!!!"

$deploymentName = "Enrich-Tag-GeoIP" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Enrich-Tag-GeoIP/azuredeploy.json"
$localTemplate = 'Enrich-Tag-GeoIP.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate


$deploymentName = "Initiate-MDEInvestigation" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Initiate-MDEInvestigation/azuredeploy.json"
$localTemplate = 'Initiate-MDEInvestigation.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
  -ResourceGroupName $ResourceGroup `
  -TemplateUri $remoteUrl `
  -TemplateParameterFile $localTemplate 

#   Run the permissions script

# figure out how to grab the object ID of the playbook just deployed
# .\Initiate-MDEInvestigation.permissions.ps1
  
  
$deploymentName = "Notify-EmailAnalysts-NewIncident" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Notify-EmailAnalysts-NewIncident/azuredeploy.json"
$localTemplate = 'Notify-EmailAnalysts-NewIncident.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate


