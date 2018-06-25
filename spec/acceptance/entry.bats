@test "creates yum.log" {
    ls /etc/logrotate.d/yum.log
}

@test "adds create setting for yum.log" {
    grep "create" /etc/logrotate.d/yum.log
}

@test "adds nocompres settings for yum.log" {
    grep "nocompress" /etc/logrotate.d/yum.log
}

@test "adds rotate setting for yum.log" {
    grep "rotate 16" /etc/logrotate.d/yum.log
}


@test "creates stuff" {
    ls /etc/logrotate.d/stuff
}

@test "adds logfiles to watch to stuff" {
    grep "/var/log/yum.log, /var/log/messages, /var/log/btmp {" /etc/logrotate.d/stuff
}

@test "adds rotate setting for stuff" {
    grep "rotate 50" /etc/logrotate.d/stuff
}