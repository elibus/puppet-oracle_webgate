# == Class oracle_webgate::config
#
# This class is called from oracle_webgate
#
class oracle_webgate::config {
  $execPath = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:'

  exec { 'configure webgate':
    command   => "${oracle_webgate::installLocation}/oblix/tools/configureWebGate/configureWebGate \
      -i ${oracle_webgate::installLocation} \
      -t WebGate \
      -w ${oracle_webgate::webgateId} \
      -m ${oracle_webgate::securityMode} \
      -c ${oracle_webgate::install} \
      -S \
      -P ${oracle_webgate::password} \
      -h ${oracle_webgate::hostname} \
      -p ${oracle_webgate::port} \
      -a ${oracle_webgate::serverId} \
      -r ${oracle_webgate::passphrase}",
    path      => $execPath,
    logoutput => true
  }

}
