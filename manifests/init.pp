# @summary Install and configure log rotation on Linux
#
# Management of `/etc/logrotate.conf` is performed as edits to avoid
# clobbering vendor defaults.
#
# The module takes the position that the files laid down by the vendor are correct and only modifies them the
# minimal amount needed to make the system work - users/admins are trusted not alter files away from the defaults.
#
# @example Install logrotate with vendor configuration
#   include logrotate
#
# @example Hiera default settings
#   logrotate::settings:
#     weekly:
#     rotate: 4
#     create:
#     dateext:
#     compress:
#
# @example Hiera logrotate entries (custom rules)
#   lograte::entries:
#     /var/log/messages:
#     /var/log/myapp:
#       settings:
#         rotate: 50
#
# @param package Name of the package providing `logrotate`
# @param settings Hash of default settings for `logrotate.conf` (see examples)
# @param entries Hash of logrotate entries to create (see examples)
class logrotate(
  String                        $package    = "logrotate",
  Hash[String,Any]              $settings   = {},
  Hash[String,Hash[String,Any]] $entries    = {},
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

  $entries.each |$key,$opts| {
    logrotate::entry { $key:
      * => $opts,
    }
  }
}
