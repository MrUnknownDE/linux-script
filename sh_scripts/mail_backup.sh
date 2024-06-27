#!/bin/bash
# Quell- und Zielverzeichnis
quelle_verzeichnis="/opt/Backups/"
ziel_verzeichnis="mail-johanneskr/"

# Rclone-Konfigurationsname
rclone_konfig="remote"

# Telegram Bot Token und Chat ID
telegram_bot_token="YOUR_TELEGRAM_BOT_TOKEN"
telegram_chat_id="YOUR_CHAT_ID"

# Funktion, um eine Nachricht an Telegram zu senden
send_telegram_message() {
    local message=$1
    curl -s -X POST "https://api.telegram.org/bot$telegram_bot_token/sendMessage" -d chat_id="$telegram_chat_id" -d text="$message"
}

# Mailcow Backup durchführen
echo "Starte Mailcow Backup..."
MAILCOW_BACKUP_LOCATION=/opt/Backups /opt/mailcow-dockerized/helper-scripts/backup_and_restore.sh backup all --delete-days 2 > backup.log 2>&1

# Überprüfen, ob das Mailcow Backup erfolgreich war
if [ $? -eq 0 ]; then
    echo "Mailcow Backup erfolgreich."
else
    echo "Fehler beim Mailcow Backup."
    error_message=$(tail -n 20 backup.log)
    send_telegram_message "Fehler beim Mailcow Backup:\n$error_message"
    echo "Fehler beim Mailcow Backup. Logs wurden gesendet." | mailx -s "FEHLER - Mail-Backup" -S smtp="smtp://mail.johanneskr.de:465" -S smtp-auth=login -S smtp-auth-user="dein_username" -S smtp-auth-password="dein_passwort" -S from="Backup Script <backup@mail.johanneskr.de>" deine_email@domain.de
    exit 1
fi

# Rclone-Befehl zum Kopieren des Verzeichnisses
echo "Die Daten werden jetzt auf den S3 Speicher hochgeladen"
sleep "5"
rclone copy "$quelle_verzeichnis" "$rclone_konfig":"$ziel_verzeichnis"

# Überprüfen, ob der Upload erfolgreich war
if [ $? -eq 0 ]; then
    echo "Backup erfolgreich auf S3 hochgeladen."
    # E-Mail-Benachrichtigung über SMTP senden
    echo "Backup erfolgreich auf S3 hochgeladen." | mailx -s "ERFOLG - Mail-Backup" -S smtp="smtp://mail.johanneskr.de:465" -S smtp-auth=login -S smtp-auth-user="dein_username" -S smtp-auth-password="dein_passwort" -S from="Backup Script <backup@mail.johanneskr.de>" deine_email@domain.de
    # Telegram-Benachrichtigung senden
    send_telegram_message "[mail.johanneskr.de] Backup erfolgreich auf S3 hochgeladen."
else
    echo "Fehler beim Hochladen des Backups auf S3."
    # E-Mail-Benachrichtigung über SMTP senden
    echo "Backup-Prozess auf mail.johanneskr.de fehlgeschlagen." | mailx -s "FEHLER - Mail-Backup" -S smtp="smtp://mail.johanneskr.de:465" -S smtp-auth=login -S smtp-auth-user="dein_username" -S smtp-auth-password="dein_passwort" -S from="Backup Script <backup@mail.johanneskr.de>" deine_email@domain.de
    # Telegram-Benachrichtigung senden
    send_telegram_message "[mail.johanneskr.de] Fehler beim Hochladen des Backups auf S3."
fi

echo "Backup-Prozess abgeschlossen."
