# Logrotate
#
# Install and configure log rotation on Linux. Edits to `/etc/logrotate.conf` are performed as edits to avoid clobbering
# vendor defaults
#
# @example Hiera default settings
#   logrotate::settings:
#     weekly:
#     rotate: 4
#     create:
#     dateext:
#     compress:
#
class logrotate(
  String                    $package    = "logrotate",
  Hash[String,Any]          $settings   = {},
  Hash[String,Hash[String,String]] $rules      = {},
) {

  package { $package:
    ensure => present,
  }



  $settings.each |$key, $opts| {
    $value = pick_default($opts, "")

    fm_replace { "/etc/logrotate.conf:${key}":
      ensure            => present,
      path              => "/etc/logrotate.conf",
      data              => "${key} ${value}",
      match             => logrotate::find_match($key),
      insert_if_missing => true,
    }
  }

}
