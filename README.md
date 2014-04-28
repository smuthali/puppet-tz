*nix Timezone
==============

Puppet-TimeZone module

#### Table of contents

1. [Overview] (#overview)
2. [Module Description - what the module essentially does] (#module description)
3. [Setup - getting started with Timezone] (#setup)
    * [What files or packages Timezone affects] (#What-does-TZ-affect)
4. [Usage - how to leverage the puppet TimeZone modules] (#usage)
5. [Limitations - OS compatibility] (#limitations)
6. [Future enhancements - additional functionality that will be added] (#enhancements)


## Overview

The puppet TimeZone module will enable the user to configure the *nix TimeZone of choice

## Module Description

The TimeZone puppet module configures TimeZone across Ubuntu/Red Hat/CentOS *nix flavors

## Setup

### What does TimeZone module affect

* TimeZone packages (.deb or rpm)
* TZ configuration file (ntp.conf)

## Usage
In site.pp it is sufficient to simply add `include '::puppet-tz'` to load, install and configure NTP module. Parameters can also be passed to the NTP module by specifying which NTP clock sources to user. For example:
```puppet
class { '::puppet-tz':
   timezone => 'America/Los_Angeles',
   }
   ```
   
## Limitations

The TimeZone puppet module has been built on and test against Puppet 3.4.2 and has also been tested on Puppet 2.7.
The module has been tested on:

* RedHat Enterprise Linux 6.x
* CentOS 6.x
* Ubuntu 10.04 and 12.04

The TimeZone module has not been tested on Gentoo, SuSe or FreeBSD.

## Enhancements

Future enhancements will include:

* Testing on other flavors of *nix
* More robust RSpec test cases

Please report bugs to satish.muthaliATgmail.com
