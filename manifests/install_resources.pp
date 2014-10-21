# == Class oracle_webgate::install_resources
#
class oracle_webgate::install_resources {
    $execPath = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:'

    File {
      ensure  => file,
      backup  => false,
      mode    => '0400',
      owner   => 'root',
      group   => 'root'
    }

    exec { "create ${oracle_webgate::downloadDir} directory":
      command => "mkdir -p ${oracle_webgate::downloadDir}",
      unless  => "test -d ${oracle_webgate::downloadDir}",
      creates => $oracle_webgate::downloadDir,
      path    => $execPath
    }

    exec { "retrieve ${oracle_webgate::remoteRepo}/${oracle_webgate::installPackage}":
      command => "wget \
        -q ${oracle_webgate::remoteRepo}/${oracle_webgate::installPackage} \
        -O ${oracle_webgate::downloadDir}/${oracle_webgate::installPackage}",
      creates => "${oracle_webgate::downloadDir}/${oracle_webgate::installPackage}",
      path    => $execPath
    }

    exec { "retrieve ${oracle_webgate::remoteRepo}/libgcc_s.so.1":
      command => "wget -q ${oracle_webgate::remoteRepo}/libgcc_s.so.1 \
        -O ${oracle_webgate::downloadDir}/libgcc_s.so.1",
      creates => "${oracle_webgate::downloadDir}/libgcc_s.so.1",
      path    => $execPath
    }

    exec { "retrieve ${oracle_webgate::remoteRepo}/libstdc++.so.6":
      command => "wget \
        -q ${oracle_webgate::remoteRepo}/libstdc++.so.6 \
        -O ${oracle_webgate::downloadDir}/libstdc++.so.6",
      creates => "${oracle_webgate::downloadDir}/libstdc++.so.6",
      path    => $execPath
    }

    #$zipFile =  $oracle_webgate::installPackage
    #$installCmd = inline_template('<%= File.basename(@zipFile, File.extname(@zipFile)) %>')
    exec { "extract ${oracle_webgate::downloadDir}/${oracle_webgate::installPackage}":
      command   => "unzip \
        -o ${oracle_webgate::downloadDir}/${oracle_webgate::installPackage} \
        -d ${oracle_webgate::downloadDir}/",
      timeout   => 0,
      path      => $execPath,
      creates   => "${oracle_webgate::downloadDir}/${oracle_webgate::install::installCmd}",
      logoutput => false,
    }

    file { "${oracle_webgate::downloadDir}/certFile.pem" :
      content => $oracle_webgate::certFile
    }

    file { "${oracle_webgate::downloadDir}/keyFile.key" :
      content => $oracle_webgate::keyFile
    }

    file { "${oracle_webgate::downloadDir}/chainFile.pem" :
      content => $oracle_webgate::chainFile
    }

    Exec["create ${oracle_webgate::downloadDir} directory"]                          ->
    Exec["retrieve ${oracle_webgate::remoteRepo}/${oracle_webgate::installPackage}"] ->
    Exec["extract ${oracle_webgate::downloadDir}/${oracle_webgate::installPackage}"]

    Exec["create ${oracle_webgate::downloadDir} directory"] ->
    Exec["retrieve ${oracle_webgate::remoteRepo}/libgcc_s.so.1"]

    Exec["create ${oracle_webgate::downloadDir} directory"] ->
    Exec["retrieve ${oracle_webgate::remoteRepo}/libstdc++.so.6"]

    Exec["create ${oracle_webgate::downloadDir} directory"] ->
    File["${oracle_webgate::downloadDir}/certFile.pem"]

    Exec["create ${oracle_webgate::downloadDir} directory"] ->
    File["${oracle_webgate::downloadDir}/keyFile.key"]

    Exec["create ${oracle_webgate::downloadDir} directory"] ->
    File["${oracle_webgate::downloadDir}/chainFile.pem"]
}
