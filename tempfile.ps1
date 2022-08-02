# deploy all playbooks to sentinel

param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)


# Playbook name variables
$EnrichEmails = "Enrich-Comment-EmailDetails"
$EnrichVirusTotal = "Enrich-Comment-VirustotalStats"
$EnrichGeoIp = "Enrich-Tag-GeoIP"
$Investigate = "Initiate-MDEInvestigation"
$NotifyAnalyst = "Notify-EmailAnalysts-NewIncident"

# Links to the raw playbooks templates
$enrichEmailsURL = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Enrich-Comment-EmailDetails/azuredeploy.json"
$EnrichVirusTotalURL = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Enrich-Comment-VirustotalStats/azuredeploy.json"
$TagGeoIP = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Enrich-Tag-GeoIP/azuredeploy.json"
$MDEInvestigation = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Initiate-MDEInvestigation/azuredeploy.json"
$NotifyEmailAnalystsNewIncident = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Notify-EmailAnalysts-NewIncident/azuredeploy.json"

$title    = ''
$question = 'Would you like to add a prefix to the playbook name? (ex. cust.LogicAppName?)'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    Read-Host "Enter prefix now" $UserPrefix
    $Playbook1 = $UserPrefix + ".$EnrichEmails"
    $Playbook2 = $UserPrefix + ".$EnrichVirusTotal"
    $Playbook3 = $UserPrefix + ".$EnrichGeoIp"
    $Playbook4 = $UserPrefix + ".$Investigate"
    $Playbook5 = $UserPrefix + ".$NotifyAnalyst"
    
    Write-Host "Make sure to update all the parameter files with the new name!"
    
} else {
    Write-Host "Your playbooks will be given the default name"
}


# Prepare unique deployment name
$suffix = Get-Random -Maximum 1000
$deploymentName = "ExampleDeployment" + $suffix


$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"



$deploymentName = "Enrich-email-plus" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/JakeD-5Q/DeployPlaybooks/main/Enrich-email-plus/azuredeploy.json"
$yourParameters = ''
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $yourParameters `
    -Verbose