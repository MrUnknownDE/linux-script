#!/bin/bash
# Quell- und Zielverzeichnis
BACKUP_SOURCE="/opt"
BACKUP_DEST="/data/backup"
ziel_verzeichnis="/"

# Rclone-Konfigurationsname
rclone_konfig="web-opt-backup"

# Telegram Bot Token und Chat ID
telegram_bot_token="YOUR_TELEGRAM_BOT_TOKEN"
telegram_chat_id="YOUR_CHAT_ID"

# Funktion, um eine Nachricht an Telegram zu senden
send_telegram_message() {
    local message=$1
    curl -s -X POST "https://api.telegram.org/bot$telegram_bot_token/sendMessage" -d chat_id="$telegram_chat_id" -d text="$message"
}

# Überprüfung, ob das Script mit dem Argument "telegram-test" aufgerufen wurde
if [ "$1" == "telegram-test" ]; then
    echo "Send Textnachricht an Telegram..." 
    send_telegram_message "Test-Nachricht%0AServer: mail.johanneskr.de%0ATime: $timestamp%0AApplication: Script-Debbuging"
    echo "Testnachricht wurde versendet..."
    exit 0
fi

# Vorhandene backup.log-Datei löschen
log_datei="backup.log"
if [ -f "$log_datei" ]; then
    echo "Lösche vorhandene backup.log-Datei..."
    rm "$log_datei"
fi

# Backup durchführen
if tar -czf $BACKUP_DEST $BACKUP_SOURCE; then
        echo "Backup erfolgreich erstellt: $BACKUP_DEST"
        send_telegram_message "[$TIMESTAMP] [$HOSTNAME] Backup erfolgreich erstellt: $BACKUP_DEST"
    else
        echo "Fehler beim Erstellen des Backups."
        send_telegram_message "[$TIMESTAMP] [$HOSTNAME] Fehler beim Erstellen des Backups."
fi

# Überprüfen, ob das Mailcow Backup erfolgreich war
if [ $? -eq 0 ]; then
    send_telegram_message "Erfolg!%0AServer: web.johanneskr.de%0ATime: $(date +"%Y-%m-%d %H:%M:%S")%0AApplication: Mailcow-Backup"
    echo "Mailcow Backup erfolgreich."
else
    echo "Fehler beim Mailcow Backup."
    error_message=$(tail -n 20 backup.log)
    send_telegram_message "Fehlgeschlagen!%0AServer: web.johanneskr.de%0ATime: $(date +"%Y-%m-%d %H:%M:%S")%0AApplication: Mailcow-Backup%0AError: $error_message"
    echo "Fehler beim Mailcow Backup. Logs wurden gesendet."
    exit 0
fi

# Rclone-Befehl zum Kopieren des Verzeichnisses
echo "Die Daten werden jetzt auf den S3 Speicher hochgeladen"
sleep "5"
rclone copy "$quelle_verzeichnis" "$rclone_konfig":"$ziel_verzeichnis"

# Überprüfen, ob der Upload erfolgreich war
if [ $? -eq 0 ]; then
    echo "Backup erfolgreich auf S3 hochgeladen."
    # Telegram-Benachrichtigung senden
    send_telegram_message "Erfolg!%0AServer: web.johanneskr.de%0ATime: $(date +"%Y-%m-%d %H:%M:%S")%0AApplication: S3-Mailcow-Backup-Upload"
else
    echo "Fehler beim Hochladen des Backups auf S3."
    # Telegram-Benachrichtigung senden
    send_telegram_message "Fehlgeschlagen!%0AServer: web.johanneskr.de%0ATime: $(date +"%Y-%m-%d %H:%M:%S")%0AApplication: S3-Mailcow-Backup-Upload"
    exit 0
fi

echo "Backup-Prozess abgeschlossen."