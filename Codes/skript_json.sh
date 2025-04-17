#!/bin/bash
if ! command -v jq &> /dev/null; then
    echo "Fehler: jq ist nicht installiert. Nutze PowerShell für JSON."
    exit 1
fi

HOST=$(jq -r '.database.host' config.json)
PORT=$(jq -r '.database.port' config.json)
echo "Datenbank: $HOST:$PORT"