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
  $manageDeps        = $oracle_webgate::params::manageDeps,
  $remoteRepo        = $oracle_webgate::params::remoteRepo,
  $downloadDir       = $oracle_webgate::params::downloadDir,
  $user              = $oracle_webgate::params::user,
  $group             = $oracle_webgate::params::group,
  $defaultLang       = $oracle_webgate::params::defaultLang,
  $installLang       = $oracle_webgate::params::installLang,
  $securityMode      = $oracle_webgate::params::securityMode
) inherits oracle_webgate::params {

  # validate parameters here
  validate_string($oracle_webgate::serverId)
  validate_string($oracle_webgate::hostname)
  validate_re($oracle_webgate::port, '\d+')
  validate_string($oracle_webgate::webgateId)
  validate_string($oracle_webgate::password)
  validate_string($oracle_webgate::passphrase)
  validate_string($oracle_webgate::certFile)
  validate_string($oracle_webgate::keyFile)
  validate_string($oracle_webgate::chainFile)
  validate_string($oracle_webgate::installPackage)
  validate_bool($oracle_webgate::manageDeps)
  validate_string($oracle_webgate::remoteRepo)
  validate_absolute_path($oracle_webgate::downloadDir)
  validate_string($oracle_webgate::user)
  validate_string($oracle_webgate::group)
  validate_string($oracle_webgate::defaultLang)
  validate_string($oracle_webgate::installLang)
  validate_string($oracle_webgate::securityMode)

  if ( str2bool($::oracle_webgate_exists) != true ) {
    notify {'oracle_webgate not found!':}

    if ( $oracle_webgate::manageDeps ) {
      class { 'oracle_webgate::dependencies':
        before => Class['oracle_webgate::install']
      }
    }

    class { 'oracle_webgate::install': } ->
    class { 'oracle_webgate::config': }  ->
    Class['oracle_webgate']
  }
}
