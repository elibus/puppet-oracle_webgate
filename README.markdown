[![Build Status](https://travis-ci.org/elibus/puppet-oracle_webgate.svg)](https://travis-ci.org/elibus/puppet-oracle_webgate)

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with oracle_webgate](#setup)
    * [What oracle_webgate affects](#what-oracle_webgate-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with oracle_webgate](#beginning-with-oracle_webgate)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This puppet module will install and configure Oracle Access Manager Webgate for Apache on Linux.

##Module Description

Oracle Access Manager Webgate has a really crappy installation process, this module automates the installation and configuration process.
This is what it does:
 - Download the installation package from a remore repository (http/https)
 - Create a temp dir where to extract the required content
 - Ensure the necessary dependencies are installed
 - Copy the system libs requirered by the install (please refer to: http://docs.oracle.com/cd/E15217_01/doc.1014/e12493.pdf)
 - Copy the OAM certificates
 - Run the installa process
 - Run the configuration process

##Setup

###What oracle_webgate affects
Notes:
 - The (crappy) Oracle installer *requires* a copy of `libgcc_s.so.1` and `libstdc++.so.6` in a specified directory to work properly. The module will take care of copying those files if they are available
 - The software will be installed in the default installation path, i.e. `/opt/netgate/access`, this cannot be changed
 - This module will install `libstc++.i686` and `libstc++.x86_64` on 64 bit systems. Puppet might fail because of multilib if a  `libstc++.i686` version newer than the `libstc++.x86_64` already installed is available (see https://projects.puppetlabs.com/issues/23245)

###Setup Requirements

Before you start, you need:
 - a working OAM server
 - OAM Certificates copied either on your puppet server on available in hiera
 - OAM Webgate installation ZIP file available on a http/https repository

###Beginning with oracle_webgate

The very basic steps needed for a user to get the module up and running.

      class { 'oracle_webgate':
        serverId        => 'oamServerId',
        hostname        => 'oam.example.com',
        webgateId       => 'thisServer',
        port            => '5575',
        password        => 'password',
        passphrase      => 'passphrase',
        remoteRepo      => 'https://www.example.com/repo/oracle',
        installPackage  => 'Oracle_Access_Manager10_1_4_3_0_linux64_APACHE24_WebGate.zip',
      }


Defaults:

| Option      | Defaults to                                     | Description                                               |
|-------------|-------------------------------------------------|-----------------------------------------------------------|
|certFile     | puppet:///modules/oracle_webgate/certFile.pem   | Certificate file                                          |
|keyFile      | puppet:///modules/oracle_webgate/keyFile.pem    | Key file                                                  |
|chainFile    | puppet:///modules/oracle_webgate/chainFile.pem  | Chain file                                                |
|downloadDir  | /tmp/oracle_webgate_install                     | Temp dir where to download and unzip installation files   |
|defaultLang  | en-us                                           |                                                           |
|installLang  | en-us                                           |                                                           |
|securityMode | cert                                            | See Oracle docs                                           |


##Usage

The module does not require any special configuration besides what just showed.
If you are using puppet 3.0+ you can take the most out of the hiera integration installing the hiera-file backend. An example might shade some light:
 - Leave the `oracle_webgate::*` variable undefined
 - Create a hiera structure like the following:

        /etc/puppet/hiera/data/default
          oracle_webgate.d/
            oracle_webgate::certFile
            oracle_webgate::keyFile
            oracle_webgate::chainFile
 - Hiera searches for a file called `oracle_webgate.d/oracle_webgate::certFile` in your hiera data folder providing the file content as content for the variable

 The outcome is... the file is copied on the client!



##Reference

### Classes

### Facts
Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

##Limitations

This module has been tested on:
 - RedHat 6+ 64 bit + OAM Webgate for Apache 2.4

It *should* work also on:
 - 32 bits RedHat systems with Apache 2.2


##Development

See https://github.com/elibus/puppet-oracle_webgate/blob/master/CONTRIBUTING.md
