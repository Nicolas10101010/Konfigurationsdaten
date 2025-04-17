$regPath = "HKCU:\Software\MyApp"
if (-not (Test-Path $regPath)) {
    Write-Host "Fehler: Registry-Schlüssel nicht gefunden!"
    exit 1
}

$dbHost = (Get-ItemProperty -Path $regPath -Name "DBHost").DBHost
$dbPort = (Get-ItemProperty -Path $regPath -Name "DBPort").DBPort
Write-Host "Datenbank: ${dbHost}:${dbPort}"