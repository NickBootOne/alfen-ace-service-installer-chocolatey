$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = 'https://knowledge.alfen.com/download/attachments/1627488257/ACE%20Service%20Installer%20v4.2.0_416.msi'
  silentArgs     = '/qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  checksum     = 'E22BC3A0B91498027DDF3220A59B255578EFB569593C622B7914230F85FB994D'
  checksumType = 'sha256'
}

Install-ChocolateyPackage @packageArgs
