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
  $remoteRepo        = undef,
  $installPackage    = undef,
  $certFile          = 'puppet:///modules/oracle_webgate/certFile.pem',
  $keyFile           = 'puppet:///modules/oracle_webgate/keyFile.pem',
  $chainFile         = 'puppet:///modules/oracle_webgate/chainFile.pem',
  $downloadDir       = '/tmp/oracle_webgate_install',
  $installLocation   = '/opt/netpoint/webgate/access',
  $defaultLang       = 'en-us',
  $installLang       = 'en-us',
  $securityMode      = 'cert',
  $install           = 'install',
  $autoUpdate        = 'No',
  $launchBrowser     = 'No',
  $dependencies      = 'libstdc++.i686',
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

  case $::architecture {
    'x86_64': {
      $libdir = 'lib64'
      $deps = [ 'libstdc++.x86_64', 'libstdc++.i686' ]
    }
    'i686': {
      $libdir = 'lib'
      $deps = 'libstdc++.i686'
    }
    default: {
      fail("${::architecture} architecture not supported")
    }
  }
}
