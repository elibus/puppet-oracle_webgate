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
  $serverId          = $oracle_webgate::params::serverId,
  $hostname          = $oracle_webgate::params::hostname,
  $webgateId         = $oracle_webgate::params::webgateId,
  $password          = $oracle_webgate::params::password,
  $passphrase        = $oracle_webgate::params::passphrase,
  $certFile          = $oracle_webgate::params::certFile,
  $keyFile           = $oracle_webgate::params::keyFile,
  $chainFile         = $oracle_webgate::params::chainFile,
  $installLocation   = $oracle_webgate::params::installLocation,
  $user              = $oracle_webgate::params::user,
  $group             = $oracle_webgate::params::group,
  $defaultLang       = $oracle_webgate::params::defaultLang,
  $installLang       = $oracle_webgate::params::installLang,
  $securityMode      = $oracle_webgate::params::securityMode
) inherits oracle_webgate::params {

  # validate parameters here
  validate_string($serverId)
  validate_string($hostname)
  validate_string($webgateId)
  validate_string($password)
  validate_string($passphrase)
  validate_absolute_path($certFile)
  validate_absolute_path($keyFile)
  validate_absolute_path($chainFile)
  validate_absolute_path($installLocation)
  validate_string($user)
  validate_string($group)
  validate_string($defaultLang)
  validate_string($installLang)
  validate_string($group)

  class { 'oracle_webgate::install': } ->
  class { 'oracle_webgate::config': }  ->
  Class['oracle_webgate']
}
