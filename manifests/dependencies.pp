# == Class oracle_webgate::dependencies
#
# This class is called from oracle_webgate::dependencies
#
class oracle_webgate::dependencies {
  package { 'libstdc++.i686':
    ensure  => installed,
    require => Package['libstdc++.x86_64']
  }

  package { 'libstdc++.x86_64':
    ensure => latest
  }
}
