# == Class oracle_webgate::uninstall
#
class oracle_webgate::uninstall {
  $execPath = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:'

  exec { 'remove directory /opt/netpoint':
    command => 'rm -fr /opt/netpoint',
    path    => $execPath,
    unless  => '! test -d /opt/netpoint'
  }

}
