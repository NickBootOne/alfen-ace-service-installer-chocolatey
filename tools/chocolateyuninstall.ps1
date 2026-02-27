$ErrorActionPreference = 'Stop'

$displayName = 'ACE Service Installer'

$keys = Get-UninstallRegistryKey -SoftwareName $displayName
if (-not $keys) { throw "Uninstall entry not found for '$displayName'." }

$key = $keys | Select-Object -First 1

# GUID uit uninstallstring halen: MsiExec.exe /X{GUID}
$guid = $null
if ($key.UninstallString -match '\{[0-9A-Fa-f\-]{36}\}') {
  $guid = $Matches[0]
} elseif ($key.PSChildName -match '^[0-9A-Fa-f\-]{36}$') {
  $guid = "{0}" -f $key.PSChildName
} elseif ($key.PSChildName -match '\{[0-9A-Fa-f\-]{36}\}') {
  $guid = $Matches[0]
}

if (-not $guid) {
  throw "Could not determine MSI ProductCode. PSChildName='$($key.PSChildName)' UninstallString='$($key.UninstallString)'"
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  silentArgs     = "/x $guid /qn /norestart"
  validExitCodes = @(0, 1605, 1614, 1641, 3010)
}

Install-ChocolateyInstallPackage @packageArgs