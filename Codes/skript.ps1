if (-not (Test-Path "config.json")) {
    Write-Host "Fehler: config.json nicht gefunden!"
    exit 1
}

$config = Get-Content config.json | ConvertFrom-Json
$url = "http://$($config.database.host):$($config.database.port)"

Write-Host "Starte Browser mit: $url"
Start-Process "chrome.exe" $url

Write-Host "Starte Test-Webserver auf Port $($config.database.port)..."
python -m http.server $config.database.port