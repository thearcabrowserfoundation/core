param()

$DestDir = "CEF"
$ArchiveName = "cef_binary.zip"
$DownloadUrl = "https://cef-builds.spotifycdn.com/cef_binary_138.0.23%2Bg26cc530%2Bchromium-138.0.7204.101_windows64.tar.bz2"
$ArchivePath = Join-Path -Path $DestDir -ChildPath $ArchiveName

# Create destination directory if it doesn't exist
if (-Not (Test-Path $DestDir)) {
    New-Item -ItemType Directory -Path $DestDir | Out-Null
}

# Check if CEF folder is not empty (assumes already downloaded)
if ((Test-Path $DestDir) -and ((Get-ChildItem -Path $DestDir | Measure-Object).Count -gt 0)) {
    Write-Host "CEF binaries already exist in $DestDir, skipping download."
    exit 0
}

Write-Host "Downloading CEF binaries from $DownloadUrl to $ArchivePath..."
Invoke-WebRequest -Uri $DownloadUrl -OutFile $ArchivePath

Write-Host "Extracting CEF binaries to $DestDir..."
Expand-Archive -LiteralPath $ArchivePath -DestinationPath $DestDir -Force

Write-Host "Cleaning up..."
Remove-Item $ArchivePath

Write-Host "CEF binaries downloaded and extracted successfully."
