#!/bin/bash

# Setze die Quell- und Zielverzeichnisse
quelle_verzeichnis="/var/lib/jellyfin"
ziel_verzeichnis="/mnt/vod/1Backup"
backup_datei="jellyfin_backup_$(date +'%Y-%m-%d').zip"
backup_max_age=7

# Überprüfe, ob das Quellverzeichnis existiert
if [ ! -d "$quelle_verzeichnis" ]; then
    echo "Das Quellverzeichnis existiert nicht."
    exit 1
fi

# Überprüfe, ob das Zielverzeichnis existiert, wenn nicht, erstelle es
if [ ! -d "$ziel_verzeichnis" ]; then
    mkdir -p "$ziel_verzeichnis"
fi

# Wechsel zum Zielverzeichnis
cd "$ziel_verzeichnis" || exit

# Führe das Backup durch
zip -r "$backup_datei" "$quelle_verzeichnis"

# Überprüfe den Status des Backups
if [ $? -eq 0 ]; then
    echo "Backup erfolgreich erstellt: $ziel_verzeichnis/$backup_datei"
else
    echo "Fehler beim Erstellen des Backups."
fi

# Lösche alte Backups
find "$ziel_verzeichnis" -name "jellyfin_backup_*.zip" -type f -mtime +"$backup_max_age" -exec rm {} \;

# Überprüfe den Status der Löschung
if [ $? -eq 0 ]; then
    echo "Ältere Backups erfolgreich gelöscht."
else
    echo "Fehler beim Löschen älterer Backups."
fi
