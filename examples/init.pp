# @PDQTest
class { "logrotate":
  settings => {
    "yearly"     => undef,
    "nocompress" => undef,
    "rotate"     => "50",
    "create"     => undef,
    "dateext"    => undef,
  },
  entries        => {
      "/var/log/messages" => {},
      "/var/log/myapp"    => {
          "settings" => {
              "rotate" => 50,
          }
      }
  }
}