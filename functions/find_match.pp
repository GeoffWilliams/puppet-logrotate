# Logrotate::Find_match()
#
# Figure out the regexp we need to use with `fm_replace` in order to update the passed in setting
#
# @example
#   logrotate::find_match("weekly")
#
# @param setting The setting to match (eg "weekly")
#
# https://tickets.puppetlabs.com/browse/PDOC-260
# return String representing the regex to match the main config file for
function logrotate::find_match($setting) >> String {

  case $setting {
    "daily", "weekly", "monthly", "yearly": {
      $match = "^(daily|weekly|monthly|yearly)"
    }
    "rotate": {
      $match = "^rotate"
    }
    default: {
      # strip any 'no' from setting
      $setting_stripped = regsubst($setting, '^(no)?(.+)', '\2')
      $match = "^(no)?${setting_stripped}"
    }
  }

  $match
}
