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

$msiArgs = "/x $guid /qn /norestart /l*v `"$env:TEMP\alfen-ace-uninstall.log`""

Write-Host "Uninstalling '$displayName' with: msiexec.exe $msiArgs"

# Direct, no prompts, wait for completion
$proc = Start-Process -FilePath "$env:SystemRoot\System32\msiexec.exe" -ArgumentList $msiArgs -Wait -PassThru

Write-Host "msiexec exit code: $($proc.ExitCode)"

# MSI "ok" exitcodes
$ok = @(0, 1605, 1614, 1641, 3010)
if ($ok -notcontains $proc.ExitCode) {
  throw "Uninstall failed with exit code $($proc.ExitCode). Check log: $env:TEMP\alfen-ace-uninstall.log"
}