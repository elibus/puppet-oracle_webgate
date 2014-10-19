# == Class: oracle_webgate
#
# Full description of class oracle_webgate here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class oracle_webgate (
  $package_name = $oracle_webgate::params::package_name,
  $service_name = $oracle_webgate::params::service_name,
) inherits oracle_webgate::params {

  # validate parameters here

  class { 'oracle_webgate::install': } ->
  class { 'oracle_webgate::config': } ~>
  class { 'oracle_webgate::service': } ->
  Class['oracle_webgate']
}
