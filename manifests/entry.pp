# @summary Create a log rotate entry under `/etc/logrotate.d`.
#
# Config file to write is guessed by taking the basename of `log_file` unless `config_file`
# is passed explicitly (eg `/var/log/yum.log` would create a file at
# `/etc/logrotate.d/yum.log`).
#
# Logrotate will take settings from the main configuration file at `/etc/logrotate.conf`
# unless they are individually overriden in the `settings` hash
#
# @example logrotate settings in the default location using default settings
#   logrotate::entry { "/var/log/yum.log":}
#
# @example logrotate settings in the default location using custom settings
#   logrotate::entry { "/var/log/yum.log":
#     settings => {
#       "rotate"   => 13,
#       "nocreate" => undef,
#     },
#   }
#
# @example logrotate settings in custom location using custom settings
#   logrotate::entry { "/var/log/yum.log":
#     config_file => "package_log.txt",
#     settings    => {
#       "rotate"   => 13,
#       "nocreate" => undef,
#     },
#   }
#
# @example managing multiple log files from a single configuration file
#   logrotate::entry { "stuff":
#     log_file => "/var/log/yum.log, /var/log/messages, /var/log/btmp",
#     settings => {
#       "rotate" => 50,
#     },
#   }
#
# @param config_file Config file to create under `/etc/logrotate.d`. A default value will be
#   picked for you based on `title` if omitted
# @param log_file File(s) to rotate via the config file
# @param settings Hash of settings to add to config file (see examples)
# @param header Warning message to add to the top of the config file
define logrotate::entry(
    Optional[String]  $config_file  = undef,
    Optional[String]  $log_file     = undef,
    Hash[String, Any] $settings     = {},
    String            $header       = "# managed by puppet, do not edit!",
) {

  $_settings = $settings.map |$key, $value| {
    "    ${key} ${value}"
  }.sort.join("\n")

  $_log_file = pick($log_file, $title)
  if $log_file {
    # if log file specified, use the title as the default config file name
    $_config_file = pick($config_file, $title, "${basename($log_file)}")
  } else {
    # otherwise the title is probably the logfile to include in the config file...
    $_config_file = pick($config_file, "${basename($_log_file)}")
  }


  file { "/etc/logrotate.d/${_config_file}":
    ensure  => file,
    owner   => "root",
    group   => "root",
    mode    => "0644",
    content => "${header}\n${_log_file} {\n${_settings}\n}"
  }
}