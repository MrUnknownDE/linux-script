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

# Ausgabe- und Fehler-Log-Dateien für das Zip-Kommando
zip_output_log="/root/zip_output.log"
zip_error_log="/root/zip_error.log"

# Führe das Backup durch und zeige einen Fortschrittsbalken an
zip -r "$backup_datei" "$quelle_verzeichnis" > "$zip_output_log" 2> "$zip_error_log" &
pid=$! # PID des Hintergrundprozesses erhalten

# Zeige den Fortschrittsbalken an, solange das ZIP-Kommando läuft
while kill -0 $pid >/dev/null 2>&1; do
    echo -n -e "Backup läuft: ."
    sleep 0.5
    echo -n -e "\r"
    echo -n -e "Backup läuft: .."
    sleep 0.5
    echo -n -e "\r"
    echo -n -e "Backup läuft: ..."
    sleep 0.5
    echo -n -e "\r"
done

# Überprüfe den Status des Backups
if [ $? -eq 0 ]; then
    echo "Backup erfolgreich erstellt: $ziel_verzeichnis/$backup_datei"
else
    echo "Fehler beim Erstellen des Backups. Siehe $ziel_verzeichnis/$zip_error_log für Details."
fi

# Lösche alte Backups
find "$ziel_verzeichnis" -name "jellyfin_backup_*.zip" -type f -mtime +"$backup_max_age" -exec rm {} \;

# Überprüfe den Status der Löschung
if [ $? -eq 0 ]; then
    echo "Ältere Backups erfolgreich gelöscht."
else
    echo "Fehler beim Löschen älterer Backups."
fi
