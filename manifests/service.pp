# == Class oracle_webgate::service
#
# This class is meant to be called from oracle_webgate
# It ensure the service is running
#
class oracle_webgate::service {

  service { $oracle_webgate::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
