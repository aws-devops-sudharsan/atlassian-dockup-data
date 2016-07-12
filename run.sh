#!/bin/bash

if [[ "$RESTORE" == "true" ]]; then
  ./restore.sh
else
  ./backup.sh
fi
if [ -n "$CRON_TIME" ]; then
echo "${CRON_TIME} BACKUP_NAME='$BACKUP_NAME' \
AWS_REGION='$AWS_REGION' \
AWS_BUCKET='$AWS_BUCKET' \
$BACKUP_TAR_OPTION='$BACKUP_TAR_OPTION' \
PREFIX='$PREFIX' \
/bin/bash /backup.sh >> /dockup.log 2>&1" >> /crontab.conf

crontab  /crontab.conf

echo "=> Running dockup backups as a cronjob for ${CRON_TIME}"

exec cron -f
fi