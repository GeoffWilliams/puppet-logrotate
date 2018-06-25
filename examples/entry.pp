# @PDQTest
logrotate::entry { "/var/log/yum.log":
  settings => {
    "nocompress" => undef,
    "create"     => undef,
    "rotate"     => 16,
  }
}

logrotate::entry { "stuff":
  log_file    => "/var/log/yum.log, /var/log/messages, /var/log/btmp",
  settings    => {
    "rotate" => 50,
  },
}
