Here's a Bash script that you can use to perform a daily MySQL database backup and retain 5 backup retention points in sql format under /backup/mysqlbackup. You can then schedule this script to run daily using Cron.

1. Make the script executable: chmod +x backup_db_vx.sh
2. Create the backup directory
3. Add the cron for example to run daily 2AM: 0 2 * * * /path/to/mysqlbackup_script.sh
4. Edit motd and add changelog e regarding the enable of custom MySQL backup script

* There is no alert for the script
* Tell client this is created based on custom situation which not within support scope.

Probably share client where the backup is stored and how to retrieve and dump it if possible or client asking.
