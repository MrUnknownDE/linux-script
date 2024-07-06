#!/bin/bash

# Konfiguration
CIFS_SHARE="//server/share"
MOUNT_POINT="/mnt/backup"
USERNAME="username"
PASSWORD="password"
BACKUP_SOURCE="/opt"
BACKUP_DEST="$MOUNT_POINT/backup_$(date +%Y%m%d_%H%M%S).tar.gz"
TELEGRAM_BOT_TOKEN="your_bot_token"
TELEGRAM_CHAT_ID="your_chat_id"

# Hostname und Zeitstempel
HOSTNAME=$(hostname)
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Funktion zum Senden der Telegram-Benachrichtigung
send_telegram_message() {
    local message=$1
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
        -d chat_id="$TELEGRAM_CHAT_ID" \
        -d text="$message"
}

# Mount CIFS Share
if mount -t cifs -o username=$USERNAME,password=$PASSWORD $CIFS_SHARE $MOUNT_POINT; then
    echo "CIFS Share erfolgreich gemountet."
    send_telegram_message "[$TIMESTAMP] [$HOSTNAME] CIFS Share erfolgreich gemountet."

    # Backup erstellen
    if tar -czf $BACKUP_DEST $BACKUP_SOURCE; then
        echo "Backup erfolgreich erstellt: $BACKUP_DEST"
        send_telegram_message "[$TIMESTAMP] [$HOSTNAME] Backup erfolgreich erstellt: $BACKUP_DEST"
    else
        echo "Fehler beim Erstellen des Backups."
        send_telegram_message "[$TIMESTAMP] [$HOSTNAME] Fehler beim Erstellen des Backups."
    fi

    # Unmount CIFS Share
    if umount $MOUNT_POINT; then
        echo "CIFS Share erfolgreich entmountet."
        send_telegram_message "[$TIMESTAMP] [$HOSTNAME] CIFS Share erfolgreich entmountet."
    else
        echo "Fehler beim Entmounten des CIFS Share."
        send_telegram_message "[$TIMESTAMP] [$HOSTNAME] Fehler beim Entmounten des CIFS Share."
    fi
else
    echo "Fehler beim Mounten des CIFS Share."
    send_telegram_message "[$TIMESTAMP] [$HOSTNAME] Fehler beim Mounten des CIFS Share."
fi
