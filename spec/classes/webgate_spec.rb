require 'spec_helper'

describe 'oracle_webgate' do
  context 'supported operating systems 64bit' do
    ['RedHat'].each do |osfamily|
      describe "oracle_webgate class with parameters on #{osfamily}" do
        let(:params) {{
           :serverId        => 'testServerId',
           :hostname        => 'test.example.com',
           :webgateId       => 'testWebgateId',
           :port            => '5575',
           :password        => 'password',
           :passphrase      => 'passphrase',
           :certFile        => '/path/to/certFile',
           :keyFile         => '/path/to/keyFile',
           :chainFile       => '/path/to/chainFile',
           :downloadDir     => '/tmp/oracle_webgate_install',
           :remoteRepo      => 'http://www.example.com/oracle',
           :installPackage  => 'Oracle_Access_Manager10_1_4_3_0_linux64_APACHE24_WebGate.zip',
        }}
        let(:facts) {{
          :osfamily              => osfamily,
          :architecture          => 'x86_64',
          :oracle_webgate_exists => false
        }}

        it { should compile.with_all_deps }

        it { should contain_class('oracle_webgate::params') }
        it { should contain_class('oracle_webgate::dependencies').
          that_comes_before('Class[oracle_webgate::install]') }
        it { should contain_class('oracle_webgate::install_resources').
          that_comes_before('oracle_webgate::install') }
        it { should contain_class('oracle_webgate::install').
          that_comes_before('oracle_webgate::config') }
        it { should contain_class('oracle_webgate::config') }

        it { should contain_package('libstdc++.x86_64') }
        it { should contain_package('libstdc++.i686') }

        it { should contain_exec('create /tmp/oracle_webgate_install directory') }
        it { should contain_exec('copy to /tmp/oracle_webgate_install/libgcc_s.so.1') }
        it { should contain_exec('copy to /tmp/oracle_webgate_install/libstdc++.so.6') }
        it { should contain_file('/tmp/oracle_webgate_install/certFile.pem') }
        it { should contain_file('/tmp/oracle_webgate_install/keyFile.key') }
        it { should contain_file('/tmp/oracle_webgate_install/chainFile.pem') }

        it { should contain_exec('run webgate install: /tmp/oracle_webgate_install/Oracle_Access_Manager10_1_4_3_0_linux64_APACHE24_WebGate') }
        it { should contain_exec('configure webgate') }

        it { should contain_exec('create /tmp/oracle_webgate_install directory').
          that_comes_before('Exec[copy to /tmp/oracle_webgate_install/libgcc_s.so.1]') }
        it { should contain_exec('create /tmp/oracle_webgate_install directory').
          that_comes_before('Exec[copy to /tmp/oracle_webgate_install/libstdc++.so.6]') }
        it { should contain_exec('create /tmp/oracle_webgate_install directory').
          that_comes_before('File[/tmp/oracle_webgate_install/certFile.pem]') }
        it { should contain_exec('create /tmp/oracle_webgate_install directory').
          that_comes_before('File[/tmp/oracle_webgate_install/chainFile.pem]') }
        it { should contain_exec('create /tmp/oracle_webgate_install directory').
          that_comes_before('File[/tmp/oracle_webgate_install/keyFile.key]') }
        it { should contain_exec('create /tmp/oracle_webgate_install directory').
            that_comes_before('Exec[retrieve http://www.example.com/oracle/Oracle_Access_Manager10_1_4_3_0_linux64_APACHE24_WebGate.zip]') }
        it { should contain_exec('retrieve http://www.example.com/oracle/Oracle_Access_Manager10_1_4_3_0_linux64_APACHE24_WebGate.zip').
            that_comes_before('Exec[extract /tmp/oracle_webgate_install/Oracle_Access_Manager10_1_4_3_0_linux64_APACHE24_WebGate.zip]') }
      end
    end
  end

  context 'supported operating systems 32bit' do
    ['RedHat'].each do |osfamily|
      describe "oracle_webgate class with parameters on #{osfamily}" do
        let(:params) {{
           :serverId        => 'testServerId',
           :hostname        => 'test.example.com',
           :webgateId       => 'testWebgateId',
           :port            => '5575',
           :password        => 'password',
           :passphrase      => 'passphrase',
           :certFile        => '/path/to/certFile',
           :keyFile         => '/path/to/keyFile',
           :chainFile       => '/path/to/chainFile',
           :downloadDir     => '/tmp/oracle_webgate_install',
           :remoteRepo      => 'http://www.example.com/oracle',
           :installPackage  => 'Oracle_Access_Manager10_1_4_3_0_linux64_APACHE24_WebGate.zip',
        }}
        let(:facts) {{
          :osfamily              => osfamily,
          :architecture          => 'i686',
          :oracle_webgate_exists => false
        }}

        it { should compile.with_all_deps }

        it { should contain_package('libstdc++.i686') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'oracle_webgate class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
        :architecture    => 'x86_64',
      }}

      it { expect { should contain_package('oracle_webgate') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end

  context 'unsupported architecture' do
    describe 'oracle_webgate class without any parameters on AIX' do
      let(:facts) {{
        :osfamily     => 'RedHat',
        :architecture => 'risc',
      }}

      it { expect { should contain_package('oracle_webgate') }.to raise_error(Puppet::Error, /architecture not supported/) }
    end
  end
end
