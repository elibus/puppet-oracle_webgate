# == Class oracle_webgate::patch
#
class oracle_webgate::patch {
  $execPath = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:'
  $patchDownloadDir = "${oracle_webgate::downloadDir}/patch"

  # Retrieve installation package
  exec { "retrieve ${oracle_webgate::remoteRepo}/${oracle_webgate::patchPackage}":
    command => "wget \
      -q ${oracle_webgate::remoteRepo}/${oracle_webgate::patchPackage} \
      -O ${oracle_webgate::downloadDir}/${oracle_webgate::patchPackage}",
    creates => "${oracle_webgate::downloadDir}/${oracle_webgate::patchPackage}",
    path    => $execPath
  }

  exec { "extract ${oracle_webgate::downloadDir}/${oracle_webgate::patchPackage}":
    command   => "unzip \
      -o ${oracle_webgate::downloadDir}/${oracle_webgate::patchPackage} \
      -d ${patchDownloadDir}",
    timeout   => 0,
    path      => $execPath,
    logoutput => false,
  }

  file { "${patchDownloadDir}/webgate_patch.sh":
    ensure => file,
    source => 'puppet:///modules/oracle_webgate/webgate_patch.sh',
    mode   => '0750',
    owner  => 'root',
    group  => 'root',
  }

  exec { "patch webgate: ${patchDownloadDir}/webgate_patch.sh":
    command   => "${patchDownloadDir}/webgate_patch.sh ${oracle_webgate::installLocation}",
    path      => $execPath,
    logoutput => true
  }

  # Dependencies
  Exec["retrieve ${oracle_webgate::remoteRepo}/${oracle_webgate::patchPackage}"] ->
  Exec["extract ${oracle_webgate::downloadDir}/${oracle_webgate::patchPackage}"] ->
  File["${patchDownloadDir}/webgate_patch.sh"]                                   ->
  Exec["patch webgate: ${patchDownloadDir}/webgate_patch.sh"]
}
