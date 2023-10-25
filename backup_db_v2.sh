#!/bin/bash

BACKUPDIR="/backup/databases"
DATE=`date +%Y%m%d`

# Log file
LOGFILE="$BACKUPDIR/logs/backup_log.$DATE.txt"

if [ ! -e $BACKUPDIR/$DATE ]; then
mkdir -p $BACKUPDIR/$DATE
chmod 700 $BACKUPDIR/$DATE
fi

mkdir -p $BACKUPDIR/logs

# Initialize a variable to store the backup status
BACKUP_STATUS=""

# Loop through the databases and perform backups
for DB_NAME in $(mysqlshow | grep -v "_schema" | awk -F "| " '{print $2}'); do
  # Perform the backup and log the output
  if mysqldump --skip-lock-tables --events --routines --triggers "$DB_NAME" | bzip2 -9czq > "$BACKUPDIR/$DATE/$DB_NAME-$DATE.sql.bz2" 2>&1 | tee -a "$LOGFILE"; then
    BACKUP_STATUS+="Backup of $DB_NAME succeeded. | File Size = `ls -alh /backup/databases/$DATE/$DB_NAME-$DATE.sql.bz2 | awk '{ print $5 }'`\n"
    echo "Backup of $DB_NAME succeeded. | File Size = `ls -alh /backup/databases/$DATE/$DB_NAME-$DATE.sql.bz2 | awk '{ print $5 }'`" >> "$LOGFILE"
  else
    BACKUP_STATUS+="Backup of $DB_NAME failed.\n"
  fi
done

/usr/bin/find $BACKUPDIR/logs ! -mtime -6|/usr/bin/xargs rm -f

# Get the current date in the desired format (YYYYMMDD)
current_date=$(date +%Y%m%d)
echo "Current Date: $current_date"

# Define the threshold date (6 days ago)
threshold_date=$(date -d "$current_date - 5 days" +%Y%m%d)
echo "Thresold Date: $threshold_date"

# Iterate over the folders and remove those older than 6 days
for folder in "$BACKUPDIR"/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]; do
    if [[ -d "$folder" ]]; then
        folder_date=$(basename "$folder")
        if [[ "$folder_date" -lt "$threshold_date" ]]; then
            echo "Removing folder: $folder"
            rm -rf "$folder"
        fi
