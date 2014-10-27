# dataprotector
[![Build Status](https://secure.travis-ci.org/mmoll/puppet-dataprotector.png)](http://travis-ci.org/mmoll/puppet-dataprotector)

## Overview

Puppet module to manage clients and servers for HP Data Protector.

### Class: dataprotector

Setting up stuff required by both clients and servers.

#### Parameters:

* `legacy -> bool`
Module should behave the oldfashioned way (Version 0.0.7 and earlier)
* `cm_ip -> string`
Use this only when legacymode enabled. See cm::net
* `cm_name -> string`
Use this only when legacymode enabled. See cm::cell
* `xinetd['ensure'] -> string`
Ensures xinetd will be installed and configured.
* `xinetd['ipv4'] -> bool`
Ensures inetd is listening on IPv4. Default is determend by Fact $::ipaddress.
* `xinetd['ipv6'] -> bool`
Ensures inetd is listening on IPv6. Default is determend by Fact $::ipaddress.

#### Example:

```puppet
  class { 'dataprotector':
    legacy  => false,
    xinetd  => {
      ensure => 'present',
      ipv4   => false,
      ipv6   => true, },
  }
```

### Class: dataprotector::client

* `cm['net'] -> string`
Subnet of the cell manager and media agents (as seen from/to the client)
* `cm['cell'] -> string`
Hostname of the cell manager (as given by the CM!)

#### Example:

```puppet
  class { 'dataprotector::client':
    cm  => {
      net  => '10.1.0.0/16',
      cell => 'cell.example.com', },
  }
```

### Class: dataprotector::server

* `unix_user -> string`
Unix user DP sould run as.
* `unix_group -> string`
Unix group DP sould run as.
* `gui_users['group'] -> string`
* `gui_users['user'] -> array`
* `gui_users['server'] -> array`
* `gui_users['domain'] -> string`
* `gui_users['server'] -> array`
Array of users that are allowed to acces cell manager via gui. Each element contains a hash with the above listed keys.
* `gui_groups['class'] -> string`
* `gui_groups['perm'] -> array`
* `gui_groups['desc'] -> string`
Array of groups determing the level of access to cell manager via gui. Each element contains a hash with the above listed keys.
* `shares['src'] -> string`
* `shares['dst'] -> string`
* `shares['options'] -> string`
Share media agent should use for backup.
* `ma_only -> bool`
Enable to add another media agent to existing cell.

#### Example:

```puppet
  class { 'dataprotector::server':
    shares     => {
      'src'      => '10.1.1.254:/vol/backup/',
      'dst'      => '/backup/',
      'options'  => 'rw,tcp,vers=3,noatime', },
    unix_user  => 'hpdp',
    gui_users  => [
      { 'group'  => 'admin',
        'user'   => ['root', 'user1', 'user2'],
        'domain' => '',
        'server' => ['hosst1', 'host2'], }],
    gui_groups => [
      { 'class'  => 'admin',
        'perm'   => [-1],
        'desc'   => "AdminGroup" }],
  }
```
