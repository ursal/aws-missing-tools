#!/bin/bash

#-- stage/prod/etc
MODE=$1

BACKUP_SCRIPT=/usr/local/bin/ec2-automate-backup2ami.sh
LOG=ec2-automate-backup2ami.$MODE.log
EMAILS=$2

source .$MODE

$BACKUP_SCRIPT -s tag -t "Backup=true" -k 14d -p -h -u -n &> $LOG
RES=$?

if [ ! "x$RES" = "x0" ]; then
#    cat $LOG | grep -q UnauthorizedOperation &&
    cat $LOG | mail -s "EC2 AMI auto-backup $MODE: failed" $EMAILS
fi
