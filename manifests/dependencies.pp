# == Class oracle_webgate::dependencies
#
# This class is called from oracle_webgate
#
class oracle_webgate::dependencies {
  notify {'oracle_webgate not found!':}
  ensure_packages($oracle_webgate::params::dependencies, {
      ensure => 'installed'
    }
  )
}
