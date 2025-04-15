#!/bin/bash
HOST=$(jq -r '.db.host' config.json)
PORT=$(jq -r '.db.port' config.json)

URL="http://$HOST:$PORT"

echo "Öffne Browser mit: $URL"
xdg-open "$URL"       #Für Linux
cmd.exe /C start "" "$URL"