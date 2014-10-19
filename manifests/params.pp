# == Class oracle_webgate::params
#
# This class is meant to be called from oracle_webgate
# It sets variables according to platform
#
class oracle_webgate::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'oracle_webgate'
      $service_name = 'oracle_webgate'
    }
    'RedHat', 'Amazon': {
      $package_name = 'oracle_webgate'
      $service_name = 'oracle_webgate'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
