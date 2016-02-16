# == Class: oracle_webgate
#
# This class will install and configure Oracle Access Manager Webgate for
# Apache on Linux.
#
# === Parameters
#
# Minimal example:
# class { 'oracle_webgate':
#    serverId        => 'oamServerId',
#    hostname        => 'oam.example.com',
#    webgateId       => 'thisServer',
#    port            => '5575',
#    password        => 'password',
#    passphrase      => 'passphrase',
#    remoteRepo      => 'https://www.example.com/repo/oracle',
#    installPackage  => 'Oracle_Access_Manager10_1_4_3_0_linux64_APACHE24_WebGate.zip',
#  }
#
# Option defaults
# * manageDeps    true
#     Should I install libstc++.i686?
# * certFile      puppet:///modules/oracle_webgate/certFile.pem
#     Certificate file
# * keyFile       puppet:///modules/oracle_webgate/keyFile.pem
#     Key file
# * chainFile     puppet:///modules/oracle_webgate/chainFile.pem
#     Chain file
# * downloadDir   /tmp/oracle_webgate_install
#     Temp dir where to download and unzip installation files
# * defaultLang   en-us
# * installLang   en-us
# * securityMode  cert
#     See Oracle docs
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
  $patchPackage      = $oracle_webgate::params::patchPackage,
  $patchVersion      = $oracle_webgate::params::patchVersion,
  $remoteRepo        = $oracle_webgate::params::remoteRepo,
  $downloadDir       = $oracle_webgate::params::downloadDir,
  $user              = $oracle_webgate::params::user,
  $group             = $oracle_webgate::params::group,
  $defaultLang       = $oracle_webgate::params::defaultLang,
  $installLang       = $oracle_webgate::params::installLang,
  $securityMode      = $oracle_webgate::params::securityMode
) inherits oracle_webgate::params {
  $continue = ! str2bool($::oracle_webgate_exists)
  if ( $continue ) {
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
    validate_re($oracle_webgate::patchVersion, '\d+')
    validate_string($oracle_webgate::remoteRepo)
    validate_absolute_path($oracle_webgate::downloadDir)
    validate_string($oracle_webgate::user)
    validate_string($oracle_webgate::group)
    validate_string($oracle_webgate::defaultLang)
    validate_string($oracle_webgate::installLang)
    validate_string($oracle_webgate::securityMode)

    class { 'oracle_webgate::dependencies': } ->
    class { 'oracle_webgate::install': }      ->
    class { 'oracle_webgate::config': }       ->
    class { 'oracle_webgate::cleanup': }      ->
    Class['oracle_webgate']

    if ( $patchVersion > 0 ) {
      validate_string($oracle_webgate::patchPackage)
      validate_re($oracle_webgate::patchPackage, '.+')
      $actualPatchVersion = ($::oracle_webgate_patch)
      if ( $patchVersion > $actualPatchVersion ) {
        notify {
          "Found patch version: ${actualPatchVersion}, required is ${patchVersion}. Installing... ":
        }

        Class['oracle_webgate::config'] ->
        class { 'oracle_webgate::patch': }
      }
    }
  }
}
