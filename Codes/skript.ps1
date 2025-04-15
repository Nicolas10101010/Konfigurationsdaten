$config = Get-Content config.json | ConvertFrom-Json
$url = "http://$($config.db.host):$($config.db.port)"

#Browser öffnen
Write-Host "Starte Browser mit: $url"
Start-Process "chrome.exe" $url

Write-Host "Starte Test-Webserver auf Port $($config.db.port)..."
python -m http.server $config.db.port