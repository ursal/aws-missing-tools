#!/bin/bash

#-- stage/prod/etc
MODE=$1

BACKUP_SCRIPT=/usr/local/bin/ec2-automate-backup2ami.sh
LOG=ec2-automate-backup2ami.$MODE.log
LOG_ERR=ec2-automate-backup2ami.$MODE.err
EMAILS=$2

source /etc/profile.d/ec2-api.sh

source .$MODE

$BACKUP_SCRIPT -s tag -t "Backup=true" -k 14d -p -h -u -n -y "Copy=true" -o "us-west-1 eu-west-1" > $LOG 2>$LOG_ERR
RES=$?

if [ ! "x$RES" = "x0" ]; then
#    cat $LOG | grep -q UnauthorizedOperation &&
    cat $LOG | mail -s "EC2 AMI auto-backup $MODE: failed" $EMAILS
fi

if [ -s $LOG_ERR ]; then
    cat $LOG_ERR | mail -s "EC2 AMI auto-backup $MODE: failed" $EMAILS
fi
