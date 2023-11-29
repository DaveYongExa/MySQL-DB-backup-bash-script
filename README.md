Yum install git
git clone [ HTTPS Link ] of the repo

Here's a Bash script that you can use to perform a daily MySQL database backup and retain 5 backup retention points in sql format on the designated directory. You can then schedule this script to run daily using Cron.

1. Make the script executable: chmod +x backup_db_v[x].sh
2. Create the backup directory
3. Add the cron for example to run daily 2AM: 0 2 * * * /path/to/mysqlbackup_script.sh
4. Edit motd and add changelog e regarding the enable of custom MySQL backup script

* There is no alert for the script but there is logs generated for v2 script
* Tell the client this is created based on a custom situation which is not within support scope.

Probably share client where the backup is stored and how to retrieve and dump it if possible or the client asks.

Sample MOTD notes:

*******************************************************************
Notice:

We have recently deployed an upgraded MySQL backup script on this server. This script ensures the regular backup of MySQL databases for data integrity and security and avoid to retrieve from R1soft which is complicated

Key Features:
- Automated daily backups of MySQL databases.
- Retention point 10 days
- Backup placed under folder /backup/databases
- Backup logs generated and stored under /backup/databases/logs

-Dave-29Nov2023

*******************************************************************
