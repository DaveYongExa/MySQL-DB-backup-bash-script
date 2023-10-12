Here's a Bash script that you can use to perform a daily MySQL database backup and retain 5 backup files under /backup/mysqlbackup. You can then schedule this script to run daily using Cron.

1. SSH into destination server with root
2. yum install git
3. Run command: git clone https://github.com/DaveYongExa/MySQL-backup-bash-script.git
4. Make the script executable: chmod +x mysqlbackup_script.sh
5. Create a folder mysqlbackup under /backup
6. Add the cron for example to run daily 2AM: 0 2 * * * /path/to/mysqlbackup_script.sh
7. Edit motd and add note regarding the enable of custom MySQL backup script
