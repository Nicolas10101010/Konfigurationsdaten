#!/bin/bash
if [ ! -f "config.env" ]; then
    echo "Fehler: config.env nicht gefunden!"
    exit 1
fi

source config.env
echo "Datenbank: $DB_HOST:$DB_PORT"