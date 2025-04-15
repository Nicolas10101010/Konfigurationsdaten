$config = Import-PowerShellDataFile config.psd1
$url = "http://$($config.db.host):$($config.db.port)"

Write-Host "Starte Browser mit: $url"
Start-Process "chrome.exe" $url

#Port-Verfügbarkeit testen
Test-NetConnection -ComputerName $config.db.host -Port $config.db.port