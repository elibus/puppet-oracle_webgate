# == Class oracle_webgate::params
#
# This class is meant to be called from oracle_webgate
# It sets variables according to platform
#
class oracle_webgate::params (
  $serverId          = undef,
  $hostname          = undef,
  $webgateId         = undef,
  $password          = undef,
  $passphrase        = undef,
  $certFile          = undef,
  $keyFile           = undef,
  $chainFile         = undef,
  $installLocation   = "/opt/netpoint/webgate/access",
  $user              = "apache",
  $group             = "apache",
  $defaultLang       = "en-us",
  $installLang       = "en-us",
  $securityMode      = "cert",
  $install           = "install",
  $autoUpdate        = "No",
  $launchBrowser     = "No",
  )
  {
  case $::osfamily{
    'RedHat' {
      installLocation   => "/opt/netpoint/webgate/access",
      user              => "apache",
      group             => "apache",
    }
    'Debian' {
        installLocation => "/opt/netpoint/webgate/access",
        user            => "httpd",
        group           => "httpd",
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
