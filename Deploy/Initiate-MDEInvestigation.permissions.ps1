param(
    [Parameter(Mandatory = $true)]$NamePrefix
)

$BaseName = "Initiate-MDEInvestigation"
$PlaybookName = $NamePrefix + .$BaseName

# get the object id of the playbook
$ID = (Get-AzResource -Name $PlaybookName -ResourceType Microsoft.Logic/workflows).Identity.PrincipalId

$MIGuid = $ID
$MI = Get-AzureADServicePrincipal -ObjectId $MIGuid

$MDEAppId = "fc780465-2017-40d4-a0c5-307022471b92"
$PermissionName = "Alert.ReadWrite.All" 

$MDEServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$MDEAppId'"
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
    -ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id

$MDEAppId = "fc780465-2017-40d4-a0c5-307022471b92"
$PermissionName = "Machine.CollectForensics" 

$MDEServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$MDEAppId'"
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
    -ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id

$MDEAppId = "fc780465-2017-40d4-a0c5-307022471b92"
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