#!/bin/bash
source config.env
URL="http://$DB_HOST:$DB_PORT"

echo "Öffne Browser mit: $URL"
xdg-open "$URL"       #Für Linux
cmd.exe /C start "" "$URL"