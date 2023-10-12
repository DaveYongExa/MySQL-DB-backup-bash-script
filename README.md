Here's a Bash script that you can use to perform a daily MySQL database backup and retain 5 backup retention points in sql format under /backup/mysqlbackup. You can then schedule this script to run daily using Cron.

1. Make the script executable: chmod +x mysqlbackup_script.sh
2. Create a folder mysqlbackup under /backup
3. Add the cron for example to run daily 2AM: 0 2 * * * /path/to/mysqlbackup_script.sh
4. Edit motd and add note regarding the enable of custom MySQL backup script
