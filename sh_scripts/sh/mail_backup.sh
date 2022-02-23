#!/bin/bash
echo "Version: 0.1"
echo "Mailserver Backup (for Mailcow)"
echo "for Hetzner StorageBox! (at a Moment)"



# MAILCOW_BACKUP_LOCATION=/opt/mailcow-dockerized/Backup /opt/mailcow-dockerized/helper-scripts/backup_and_restore.sh backup all --delete-days 7
sshpass -p 'password' rsync --progress -e 'ssh -p23 -o StrictHostKeyChecking=no' --recursive /opt/mailcow-dockerized/Backup/ uXXX-subXXX@uXXX.your-storagebox.de:./
echo "Finish"
