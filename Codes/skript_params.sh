#!/bin/bash  
HOST="localhost"  
PORT="3306"  
while [[ "$#" -gt 0 ]]; do  
    case $1 in  
        --host) HOST="$2"; shift ;;  
        --port) PORT="$2"; shift ;;  
        *) echo "Unbekannter Parameter: $1"; exit 1 ;;  
    esac  
    shift  
done  
echo "Datenbank: $HOST:$PORT"  