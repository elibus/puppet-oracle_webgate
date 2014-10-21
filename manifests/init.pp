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
  $port              = $oracle_webgate::params::port,
  $webgateId         = $oracle_webgate::params::webgateId,
  $password          = $oracle_webgate::params::password,
  $passphrase        = $oracle_webgate::params::passphrase,
  $certFile          = $oracle_webgate::params::certFile,
  $keyFile           = $oracle_webgate::params::keyFile,
  $chainFile         = $oracle_webgate::params::chainFile,
  $installPackage    = $oracle_webgate::params::installPackage,
  $version           = $oracle_webgate::params::version,
  $remoteRepo        = $oracle_webgate::params::remoteRepo,
  $downloadDir       = $oracle_webgate::params::downloadDir,
  $installLocation   = $oracle_webgate::params::installLocation,
  $user              = $oracle_webgate::params::user,
  $group             = $oracle_webgate::params::group,
  $defaultLang       = $oracle_webgate::params::defaultLang,
  $installLang       = $oracle_webgate::params::installLang,
  $securityMode      = $oracle_webgate::params::securityMode
) inherits oracle_webgate::params {

  # validate parameters here
  validate_string($oracle_webgate::serverId)
  validate_string($oracle_webgate::hostname)
  validate_string($oracle_webgate::webgateId)
  validate_string($oracle_webgate::password)
  validate_string($oracle_webgate::passphrase)
  validate_absolute_path($oracle_webgate::certFile)
  validate_absolute_path($oracle_webgate::keyFile)
  validate_absolute_path($oracle_webgate::chainFile)
  validate_absolute_path($oracle_webgate::downloadDir)
  validate_string($oracle_webgate::remoteRepo)
  validate_string($oracle_webgate::installPackage)
  validate_absolute_path($oracle_webgate::installLocation)
  validate_string($oracle_webgate::user)
  validate_string($oracle_webgate::group)
  validate_string($oracle_webgate::defaultLang)
  validate_string($oracle_webgate::installLang)
  validate_string($oracle_webgate::group)

  $found = oracle_webgate_exists( $oracle_webgate::installLocation, $oracle_webgate::version )
  if ( ! $found ) {
    notify {"oracle_webgate::install ${$oracle_webgate::installLocation} does not exists":}

    class { 'oracle_webgate::install': } ->
    class { 'oracle_webgate::config': }  ->
    Class['oracle_webgate']
  }
}
