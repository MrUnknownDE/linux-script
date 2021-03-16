#/bin/bash
echo "Mailserver Backup"
echo "for Hetzner StorageBox!"



MAILCOW_BACKUP_LOCATION=/opt/mailcow-dockerized/Backup /opt/mailcow-dockerized/helper-scripts/backup_and_restore.sh backup all --delete-days 1
rsync --progress -e 'ssh -p xxx' --recursive /opt/mailcow-dockerized/Backup uXXXX-subXXX@uXXXX.your-storagebox.de:./
echo "Finish"
done