#!/bin/bash

export PATH=$PATH:/usr/bin:/usr/local/bin:/bin

# Get timestamp

export EXPORT_DATETIME=$(date -u +"%Y-%m-%d-%H-%M-%S-%Z")

readonly tarball=$BACKUP_NAME-$EXPORT_DATETIME.tar.gz

# Create a gzip compressed tarball with the volume(s)

tar -cvf $tarball $BACKUP_TAR_OPTION

# Upload the backup to S3 with timestamp
aws s3 --region $AWS_REGION cp /$tarball s3://$AWS_BUCKET/$PREFIX/$tarball --sse

# Clean up
rm /$tarball
