# == Class oracle_webgate::cleanup
#
class oracle_webgate::cleanup {
  $execPath = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:'

  exec { "removing temp files: ${oracle_webgate::downloadDir}/":
    command => "rm -fr ${oracle_webgate::downloadDir}",
    path    => $execPath,
    unless  => "! test -d ${oracle_webgate::downloadDir}"
  }

}
