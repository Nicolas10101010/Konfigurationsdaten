if (-not (Test-Path "config.psd1")) {
    Write-Host "Fehler: config.psd1 nicht gefunden!"
    exit 1
}

$config = Import-PowerShellDataFile config.psd1
$url = "http://$($config.db.host):$($config.db.port)"

Write-Host "Starte Browser mit: $url"
Start-Process "chrome.exe" $url

Test-NetConnection -ComputerName $config.db.host -Port $config.db.port