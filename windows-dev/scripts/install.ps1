# Stop immediately if any error happens
$ErrorActionPreference = "Stop"

# Enable all versions of TLS
[System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3")

# Install Chocolatey package manager
Write-Host "Installing Chocolatey package manager"
$env:chocolateyUseWindowsCompression = 'true'
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Host "Chocolatey package manager installed"

# Download and install 7-Zip
$seven_zip_version_suffix = "${env:SEVEN_ZIP_VERSION}" -replace "\.", ""
$seven_zip_dist_name = "7z${seven_zip_version_suffix}-x64.msi"
$seven_zip_dist = "${PSScriptRoot}\${seven_zip_dist_name}"
if (-not (Test-Path -Path "${seven_zip_dist}")) {
  $seven_zip_dist = "${env:TMP}\${seven_zip_dist_name}"
  $seven_zip_url = "${env:SEVEN_ZIP_DOWNLOAD_URL}/${seven_zip_dist_name}"
  Write-Host "Downloading 7-Zip from ${seven_zip_url} into ${seven_zip_dist}"
  (New-Object System.Net.WebClient).DownloadFile("${seven_zip_url}", "${seven_zip_dist}")
}
Write-Host "Installing 7-Zip from ${seven_zip_dist} into ${env:SEVEN_ZIP_HOME}"
$p = Start-Process -FilePath "${seven_zip_dist}" `
  -ArgumentList ("/norestart", "/quiet", "/qn", "ALLUSERS=1", "TargetDir=""${env:SEVEN_ZIP_HOME}""") `
  -Wait -PassThru
if (${p}.ExitCode -ne 0) {
  throw "Failed to install 7-Zip"
}
Write-Host "7-Zip ${env:SEVEN_ZIP_VERSION} installed into ${env:SEVEN_ZIP_HOME}"

# Install Git for Windows
& choco install git -y --no-progress --version "${env:GIT_VERSION}" --force -params "'/NoShellIntegration /NoGuiHereIntegration /NoShellHereIntegration'"
if (${LastExitCode} -ne 0) {
  throw "Failed to install Git ${env:GIT_VERSION}"
}
Write-Host "Git ${env:GIT_VERSION} installed"

# Cleanup
Write-Host "Removing all files and directories from ${env:TMP}"
Remove-Item -Path "${env:TMP}\*" -Recurse -Force