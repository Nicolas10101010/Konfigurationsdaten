#!/bin/bash
HOST=$(jq -r '.database.host' config.json)
PORT=$(jq -r '.database.port' config.json)
URL="http://$HOST:$PORT"

echo "Öffne Browser mit: $URL"
start "" "$URL"  # Funktioniert in Git Bash auf Windows