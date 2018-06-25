#!/bin/bash
# If this file exists it will be run on the system under test before puppet runs
# to setup any prequisite test conditions, etc

yum install -y logrotate

cat > /etc/logrotate.conf <<EOF
# see "man logrotate" for details
# rotate log files weekly
monthly

# keep 4 weeks worth of backlogs
rotate 12

# create new (empty) log files after rotating old ones
nocreate

# use date as a suffix of the rotated file
dateext

# uncomment this if you want your log files compressed
compress

# RPM packages drop log rotation information into this directory
include /etc/logrotate.d

# no packages own wtmp and btmp -- we'll rotate them here
/var/log/wtmp {
    monthly
    create 0664 root utmp
	minsize 1M
    rotate 1
}

/var/log/btmp {
    missingok
    monthly
    create 0600 root utmp
    rotate 1
}
EOF