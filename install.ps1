$repo  = "m83637466-alt/fluffy-octo-broccoli"
$api   = "https://api.github.com/repos/$repo/releases/latest"
$release = Invoke-RestMethod -Uri $api -Headers @{ "User-Agent" = "installer" }

$asset = $release.assets | Where-Object { $_.name -like "*.exe" } | Select-Object -First 1

if (-not $asset) {
    exit 1
}

$tmpPath = "$env:TEMP\$($asset.name)"
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $tmpPath

Start-Process -FilePath $tmpPath -Wait