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
 - Install the necessary dependencies (optional)
 - Copy the system libs requirered by the install (please refer to: http://docs.oracle.com/cd/E15217_01/doc.1014/e12493.pdf)
 - Copy the OAM certificates
 - Run the installa process
 - Run the configuration process

This module has been tested on: RedHat 6+ 64 bit + OAM Webgate for Apache 2.4
It *should* also on 32bit RedHat systems and Debian with 32bit modules and Apache 2.2.

It is compatibile with:
 - Puppet >= 2.7.0
 - Ruby >= 1.8.7


##Setup

###What oracle_webgate affects
Notes:
 - The (crappy) Oracle installer *requires* a copy of `libgcc_s.so.1` and `libstdc++.so.6` in a specified directory to work properly. The module will take care of copying those files if they are available
 - The software will be installed in the default installation path, i.e. `/opt/netgate/access`, this cannot be changed

###Setup Requirements **OPTIONAL**

 
###Beginning with oracle_webgate

Before you start, you need:
 - a working OAM server
 - OAM Certificates copied either on your puppet server on available in hiera
 - OAM Webgate installation ZIP file available on a http/https repository

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

Defaults

| Option      | Defaults to                                     | Description                                               |
|-------------|-------------------------------------------------|-----------------------------------------------------------|
|manageDeps   | true                                            | Should I install libstc++.i686?                           |
|certFile     | puppet:///modules/oracle_webgate/certFile.pem   | Certificate file                                          |
|keyFile      | puppet:///modules/oracle_webgate/keyFile.pem    | Key file                                                  |
|chainFile    | puppet:///modules/oracle_webgate/chainFile.pem  | Chain file                                                |
|downloadDir  | /tmp/oracle_webgate_install                     | Temp dir where to download and unzip installation files   |
|defaultLang  | en-us                                           |                                                           |
|installLang  | en-us                                           |                                                           |
|securityMode | cert                                            | See Oracle docs                                           |

##Usage

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here. 

##Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

##Limitations

This is where you list OS compatibility, version compatibility, etc.

##Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

##Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
