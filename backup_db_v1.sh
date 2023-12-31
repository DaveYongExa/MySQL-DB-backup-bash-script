#!/bin/bash

# Main backup directory
MAIN_BACKUP_DIR="/backup/mysqlbackup"

# Number of retention points
RETENTION_DAYS=5

# Current date
CURRENT_DATE=$(date +%Y-%m-%d)

# Daily backup directory
DAILY_BACKUP_DIR="$MAIN_BACKUP_DIR/$CURRENT_DATE"

# Ensure the daily backup directory exists, if not, create it
mkdir -p $DAILY_BACKUP_DIR

# MySQL list databases command
MYSQL_CMD="mysql -e 'SHOW DATABASES;'"

# Get the list of databases, excluding system databases like information_schema, mysql, and performance_schema
DATABASES=$(eval $MYSQL_CMD | grep -Ev "(Database|information_schema|mysql|performance_schema)")

# Backup each database in separate .sql files
for DB in $DATABASES; do
    # Backup file name for each database
    BACKUP_FILE="$DAILY_BACKUP_DIR/${DB}_backup.sql"

    # MySQL dump command for individual database
    mysqldump --skip-lock-tables --databases $DB > $BACKUP_FILE

    # Check if the backup was successful
    if [ $? -eq 0 ]; then
        echo "Backup of database $DB completed successfully."
    else
        echo "Error: Backup of database $DB failed."
    fi
done

# Delete old backup files
find $MAIN_BACKUP_DIR -mindepth 1 -maxdepth 1 -type d -mtime +$RETENTION_DAYS -exec rm -r {} \;

echo "Old backup files older than $RETENTION_DAYS days have been deleted."
