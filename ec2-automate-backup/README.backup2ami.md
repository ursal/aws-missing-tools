# Introduction:
ec2-automate-backup2ami is a very similar tool, which (unlike ec2-automate-backup) snapshots whole EC2 instances by creating AMI. This should significantely simplify the restoration process. Also, there's little addon which finds instances tagged for backup throughout all regions.
Since ec2-automate-backup2ami based on the latest version of colinbjohnson/aws-missing-tools/ec2-automate-backup, the syntax has slightly changed (in comparing with my version of ec2-automate-backup):
* -v option is removed
* -i option specifies the single instance (instance id) to backup (either -i or -t option is required)
* -k option now takes suffix which specifies the dimension of the purging interval: d for days (default), h for hours, m for minutes
* -s option should be either "instanceid" or "tag"

# Known bugs:
It might not work under MAC OS/X (check and correct the 4th line in get_purge_after_date() function)

# Directions For Use:
## Example of Use:
Here is how I execute it from cron:
`0 3 * * * . $HOME/.bashrc; ec2-automate-backup2ami.sh -s tag -t "Backup=true" -k 14d -p -h -u -n > ec2-automate-backup2ami.stage.log 2>&1 || cat ec2-automate-backup2ami.stage.log | grep -q UnauthorizedOperation && cat ec2-automate-backup2ami.stage.log | mail -s "EC2 AMI auto-backup: failed" monitor@mydomain`

- Author: jazzl0ver, based on Colin Johnson's ec2-automate-backup script
- Date: 2014-07-22
- Version 1.0
- License Type: GNU GENERAL PUBLIC LICENSE, Version 3
