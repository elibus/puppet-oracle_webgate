# == Class oracle_webgate::install
#
class oracle_webgate::install {
  $execPath = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:'
  $zipFile =  $oracle_webgate::installPackage
  $installCmd = inline_template('<%= File.basename(zipFile, File.extname(zipFile)) %>')

  exec { 'run install':
    command => "./${installCmd} -silent \
      -W gccLibraryLocationBean.libraryLocation=${oracle_webgate::installPackage} \
      -P webgate.installLocation=${oracle_webgate::installLocation} \
      -W localePanel.defaultLang=${oracle_webgate::defaultLang} \
      -W localePanel.installLanguages=${oracle_webgate::installLang} \
      -W userInfoBean.user=${oracle_webgate::user} \
      -W userInfoBean.group=${oracle_webgate::group} \
      -W securityModeBean.securityModeChoices=${oracle_webgate::securityMode} \
      -W certModeBean.serverID=${oracle_webgate::serverId} \
      -W certModeBean.hostName=${oracle_webgate::hostname} \
      -W certModeBean.webgateID=${oracle_webgate::webgateId} \
      -W certModeBean.portNumber=${oracle_webgate::port} \
      -W certModeBean.password=${oracle_webgate::password} \
      -W certModeBean.passphrase=${oracle_webgate::passphrase} \
      -W certModeBean.passphraseVerify=${oracle_webgate::passphrase} \
      -W installOrRequestCertBean.installOrRequest=${oracle_webgate::install} \
      -W copyCertificatesInputBean.certFile=${oracle_webgate::downloadDir}/${oracle_webgate::certFile} \
      -W copyCertificatesInputBean.keyFile=${oracle_webgate::downloadDir}/${oracle_webgate::keyFile} \
      -W copyCertificatesInputBean.chainFile=${oracle_webgate::downloadDir}/${oracle_webgate::chainFile} \
      -W askAutoUpdateWSBean.askAutoUpdateWSField=No \
      -W askLaunchBrowserBean.launchBrowser=No",
    path    => $execPath
  }

  class { 'oracle_webgate::install_resources': } ->
  Class ['oracle_webgate::install']

}
