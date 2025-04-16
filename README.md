
# **LB2: Konfigurationsdaten auslagern – Dokumentation**  
**Von Nicolas Manser**

## **Inhaltsverzeichnis**
1. [Übersicht](#übersicht)  
2. [Möglichkeiten zur Auslagerung von Konfigurationsdaten](#möglichkeiten-zur-auslagerung-von-konfigurationsdaten)  
3. [Praktische Beispiele](#praktische-beispiele)  
   - [Bash (Linux)](#bash-linux)  
   - [PowerShell (Windows)](#powershell-windows)  
4. [Vergleich der Methoden](#vergleich-der-methoden)  
5. [Screenshots der Ausführung](#screenshots-der-ausführung)  
6. [Reflexion](#reflexion)  
7. [Quellcode & Dateien](#quellcode--dateien)  

---

## **Übersicht**  
In dieser LB2 geht es darum, Konfigurationsdaten (wie IP-Adressen, URLs oder Ports) aus Skripten auszulagern, damit sie nicht direkt im Code stehen.  
Das Ziel ist es, verschiedene Methoden zu vergleichen, wie man diese Daten extern speichern und in Skripten einlesen kann.  
Untersucht wurden **Bash (Linux)** und **PowerShell (Windows)**.

---

## **Möglichkeiten zur Auslagerung von Konfigurationsdaten**

Folgende Methoden wurden untersucht:

- **Umgebungsvariablen** (z. B. in Bash: `export DB_HOST=localhost`)  
- **Externe Dateien** wie `.env`, `.json`, `.ini`, `.psd1`  
- **Kommandozeilenparameter** (z. B. `./skript.sh --port 3306`)  
- **Registry** (nur für Windows/PowerShell relevant)

---

## **Praktische Beispiele**

### **Bash (Linux)**  

**Beispiel 1: .env-Datei**  
**Datei `config.env`:**
```bash
DB_HOST=localhost
DB_PORT=3306
```

**Skript `skript.sh`:**
```bash
#!/bin/bash
#Konfiguration einlesen
source config.env
echo "Datenbank: $DB_HOST:$DB_PORT"
```

**Beispiel 2: JSON-Datei mit jq**  
**Datei `config.json`:**
```json
{
  "database": {
    "host": "localhost",
    "port": 3306
  }
}
```

**Skript `skript_json.sh`:**
```bash
#!/bin/bash
#JSON-Daten extrahieren
HOST=$(jq -r '.database.host' config.json)
PORT=$(jq -r '.database.port' config.json)
echo "Datenbank: $HOST:$PORT"
```

---

### **PowerShell (Windows)**  

**Beispiel 1: .psd1-Datei**  
**Datei `config.psd1`:**
```powershell
@{
    db = @{
        host = 'localhost'
        port = 3306
    }
}
```

**Skript `skript.ps1`:**
```powershell
#Konfiguration laden
$config = Import-PowerShellDataFile config.psd1
Write-Host "Datenbank: $($config.db.host):$($config.db.port)"
```

**Beispiel 2: JSON-Datei**  
**Datei `config.json` (wie oben)**

**Skript `skript_json.ps1`:**
```powershell
$config = Get-Content config.json | ConvertFrom-Json
Write-Host "Datenbank: $($config.database.host):$($config.database.port)"
```

---

## **Vergleich der Methoden**

| Kriterium             | Bash + .env                   | Bash + JSON                  | PowerShell + .psd1          | PowerShell + JSON           |
|----------------------|-------------------------------|------------------------------|-----------------------------|-----------------------------|
| **Einfachheit**       | Sehr einfach (keine Tools nötig) | Mittel (abhängig von jq)     | Einfach (nativ unterstützt) | Einfach (nativ unterstützt) |
| **Datenstruktur**     | Flach (keine Hierarchien)     | Komplex (Verschachtelung)    | Komplex (Hashtables)        | Komplex (Verschachtelung)   |
| **Portabilität**      | Nur Bash/Linux                | Plattformübergreifend        | Nur PowerShell              | Plattformübergreifend       |
| **Sicherheit**        | Sensible Daten im Klartext    | Sensible Daten im Klartext   | Keine Codeausführung        | Keine Codeausführung        |

**Bewertung:**

- **Beste Methode für Bash:** `.env`-Dateien, da einfach und schnell.  
- **Beste Methode für PowerShell:** `.psd1`-Dateien, da natives Format und sicher.  
- **Plattformübergreifend:** `JSON`, da es in beiden Shells gut funktioniert.

---

## **Screenshots der Ausführung** 
(hinzufügen)

### **Bash (Linux):**
```bash
$ ./skript.sh
Datenbank: localhost:3306

$ ./skript_json.sh
Datenbank: localhost:3306
```

### **PowerShell (Windows):**
```powershell
PS> .\skript.ps1
Datenbank: localhost:3306

PS> .\skript_json.ps1
Datenbank: localhost:3306
```

---

## **Reflexion**

**Erkenntnisse:**

**Vorteile externer Konfiguration:**

- Änderungen erfordern keine Anpassung des Codes.  
- Sensible Daten (wie Passwörter) können leichter geschützt werden.

**Herausforderungen:**

- JSON in Bash: Ohne jq ist das Parsen mühsam.  
- PowerShell: .psd1-Dateien sind zwar praktisch, aber nicht portabel.

**Was ich gelernt habe:**

- Die Trennung von Code und Konfiguration macht Skripte wartbarer.  
- Einfache Projekte profitieren von `.env`-Dateien, komplexe von `JSON` oder `.psd1`.

**Verbesserungsvorschläge:**

- **Sicherheit:** Sensible Daten in `.env`-Dateien verschlüsseln.  
- **Fehlerbehandlung:** Skripte robust gegen fehlende Dateien machen.

---

## **Quellcode & Dateien**

**Skripte und Konfigurationsdateien:**

- **Bash:** `skript.sh`, `skript_json.sh`, `config.env`, `config.json`  
- **PowerShell:** `skript.ps1`, `skript_json.ps1`, `config.psd1`, `config.json`  

**GitHub-Repository:** Link zum Projekt  

**Autor:** Nicolas Manser  
**Version:** 1.0
