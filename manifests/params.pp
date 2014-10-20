# == Class oracle_webgate::params
#
# This class is meant to be called from oracle_webgate
# It sets variables according to platform
#
class oracle_webgate::params (
  $serverId          = undef,
  $hostname          = undef,
  $port              = undef,
  $webgateId         = undef,
  $password          = undef,
  $passphrase        = undef,
  $certFile          = undef,
  $keyFile           = undef,
  $chainFile         = undef,
  $remoteRepo        = undef,
  $installPackage    = undef,
  $downloadDir       = '/tmp/oracle_webgate_install',
  $installLocation   = '/opt/netpoint/webgate/access',
  $defaultLang       = 'en-us',
  $installLang       = 'en-us',
  $securityMode      = 'cert',
  $install           = 'install',
  $autoUpdate        = 'No',
  $launchBrowser     = 'No',
  )
  {
  case $::osfamily {
    'RedHat': {
      $user  = 'apache'
      $group = 'apache'
    }
    'Debian': {
      $user  = 'httpd'
      $group = 'httpd'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
