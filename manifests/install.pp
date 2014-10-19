# == Class oracle_webgate::install
#
class oracle_webgate::install {

  package { $oracle_webgate::package_name:
    ensure => present,
  }
}
