# == Class oracle_webgate::install
#
class oracle_webgate::install {
    #include oracle_webgate::install_resources

  # check if the oracle webgate already exists - TODO
  # $found = oracle_webgate_exists( $oracleHome ) 
  $found = false
  if $found == undef {
    $continue = true
  } else {
    if ( $found ) {
      $continue = false
    } else {
      notify {"oracle_webgate::install ${$oracle_webgate::installLocation} does not exists":}
      $continue = true
    }
  }

  if ( $continue ) {
    $execPath = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:'

  }

  class { 'oracle_webgate::install_resources': } ->
  Class ['oracle_webgate::install']
}
