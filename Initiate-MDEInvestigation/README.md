# Initiate-MDEInvestigation

This playbooks combines the Run-[MDEAntivirus](https://github.com/Azure/Azure-Sentinel/tree/master/Playbooks/Run-MDEAntivirus), [Start-MDEAutomatedInvestigation](https://github.com/Azure/Azure-Sentinel/tree/master/Playbooks/Start-MDEAutomatedInvestigation), and [Get-MDEInvestigationPackage](https://github.com/Azure/Azure-Sentinel/tree/master/Playbooks/Get-MDEInvestigationPackage) into one, easy-to-use, Alert-trigger playbook.

## Prerequisites


[provide screenshot]()

## Usage

For a given incident:

1. Go to "View full details"
2. Click "View playbooks"
3. Find this in the list
4. Click "run"
5. Go to the comments tab for the result links

## Screenshots

## Deploy

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FJakeD-5Q%2FCustomPlaybooks%2Fmain%2FInitiate-MDEInvestigation%2Fazuredeploy.json)

## Post Deploy

You will have to run the following script to grant this service principal with the required permissions for it to perform the tasks described above. 

```powershell
# the AzureAD required permissions to perform MDE AV scans, collect forensic pkgs, start automated investigations

param(
    [Parameter(Mandatory = $true)]$PlaybookName
)

# get the object id of the playbook
$ID = (Get-AzResource -Name $PlaybookName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId

$MIGuid = $ID
$MI = Get-AzureADServicePrincipal -ObjectId $MIGuid

# Collect Forensic package~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MDEAppId = "fc780465-2017-40d4-a0c5-307022471b92"
$PermissionName = "Machine.CollectForensics" 

$MDEServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$MDEAppId'"
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
    -ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id

# Run Anti-Virus Scan~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$PermissionName = "Machine.Scan" 

$MDEServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$MDEAppId'"
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
    -ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id

$PermissionName = "Machine.Read.All"
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
    -ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id

$PermissionName = "Machine.ReadWrite.All"
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
    -ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id

# Automated Investigation~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$PermissionName = "Alert.ReadWrite.All" 

$MDEServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$MDEAppId'"
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
    -ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id
```
