#!/bin/bash

export PATH=$PATH:/usr/bin:/usr/local/bin:/bin

# Find last backup file

: ${LAST_BACKUP:=$(aws s3 ls s3://$AWS_BUCKET/$PREFIX/ | awk -F " " '{print $4}' | grep ^$BACKUP_NAME | sort -r | head -n1)}

# Download backup from S3

aws s3 cp s3://$AWS_BUCKET/$PREFIX/$LAST_BACKUP $LAST_BACKUP

# Extract backup
tar -xvf $LAST_BACKUP $RESTORE_TAR_OPTION

# Clean up
rm $LAST_BACKUP