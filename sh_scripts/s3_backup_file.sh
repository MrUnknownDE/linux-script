#!/bin/bash

# Konfiguration
S3CMD_PATH="/usr/bin/s3cmd"  # Pfad zu s3cmd
S3_BUCKET="s3://<Bucketname>"  # S3-Bucket-URL
BACKUP_DIR="/opt/Backup"  # Verzeichnis, in dem Mailcow-Backups liegen

# Mailcow Backup durchführen
echo "Starte Mailcow Backup..."
MAILCOW_BACKUP_LOCATION=/opt/Backup /opt/mailcow-dockerized/helper-scripts/backup_and_restore.sh backup all --delete-days 2

# S3-Upload durchführen
echo "Lade Backup auf S3 hoch..."
$S3CMD_PATH put --multipart-chunk-size-mb=250 --recursive $BACKUP_DIR $S3_BUCKET

# Überprüfen, ob der Upload erfolgreich war
if [ $? -eq 0 ]; then
    echo "Backup erfolgreich auf S3 hochgeladen."
else
    echo "Fehler beim Hochladen des Backups auf S3."
fi

echo "Backup-Prozess abgeschlossen."
