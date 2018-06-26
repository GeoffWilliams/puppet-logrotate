@test "yearly set" {
    grep ^yearly /etc/logrotate.conf
}

@test "monthly removed set" {
    ! grep ^montly /etc/logrotate.conf
}


@test "nocompress set" {
    grep ^nocompress /etc/logrotate.conf
}

@test "compress removed" {
    ! grep ^compress /etc/logrotate.conf
}


@test "rotate set" {
    grep "^rotate 50" /etc/logrotate.conf
}

@test "old rotate updated" {
    ! grep "^rotate 12" /etc/logrotate.conf
}


@test "create set" {
    grep ^create /etc/logrotate.conf
}

@test "nocreate removed" {
    ! grep ^nocreate /etc/logrotate.conf
}

@test "dateext set" {
    grep ^dateext /etc/logrotate.conf
}

@test "entry created for /var/log/messages" {
    ls /etc/logrotate.d/messages
}

@test "entry created for /var/log/myapp" {
    ls /etc/logrotate.d/myapp
}

@test "logging configured correctly for /var/log/myapp" {
    grep "rotate 50" /etc/logrotate.d/myapp
}