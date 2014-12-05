# == Class: dataprotector
#
# Manages clients and servers for HP Data Protector
#
# === Parameters
# MainClass:
# [*legacy*]
# Module should behave like older versions (until ver. 0.0.7).
#
# [*cm_ip*]
# See [*cm::net*] in ClientClass.
#
# [*cm_name*]
# See [*cm::cell*] in ClientClass.
#
# [*xinetd*]
# [*xinetd::ensure*]
# [*xinetd::ipv4*]
# [*xinetd::ipv6*]
# Hash that ensure xinetd is installed and properly configured for IPv4 ond/or IPv6.
# Set to absent if you want to use other modules to configure xinetd.
#
# ClientClass:
# [*cm*]
# [*cm::net*]
# Subnet of the cell manager and media agents (as seen from/to the client)
# [*cm::name*]
# Hostname of the cell manager (as given by the CM!)
#
# ServerClass:
# [*unix_user*]
# Unix user that DP is running.
#
# [*unix_group*]
# Unix group that DP is running.
#
# [*gui_users*]
# [*gui_users::group*]
# [*gui_users::server*]
# [*gui_users::domain*]
# [*gui_users::server*]
# Array of users that are allowed to acces cell manager via gui. Each element contains a hash with the above listed keys.
#
# [*gui_groups*]
# [*gui_groups::class*]
# [*gui_groups::perm*]
# [*gui_groups::desc*]
# Array of groups determing the level of access to cell manager via gui. Each element contains a hash with the above listed keys.
#
# [*shares*]
# [*shares::src*]
# [*shares::dst*]
# [*shares::options*]
# Share media agent should use for backup.
#
# [*ma_only*]
# Enable to add another media agent to existing cell.
#
# === Examples
# class { 'dataprotector':
# legacy => false,
# xinetd => {
# ensure => 'present',
# ipv4 => false,
# ipv6 => true, },
# }
#
# class { 'dataprotector::client':
# cm => {
# net => '10.1.0.0/16',
# cell => 'cell.example.com', },
# }
#
# class { 'dataprotector::server':
# shares => {
# 'src' => '10.1.1.254:/vol/backup/',
# 'dst' => '/backup/',
# 'options' => 'rw,tcp,vers=3,noatime', },
# unix_user => 'hpdp',
# gui_users => [
# { 'group' => 'admin',
# 'user' => ['root', 'user1', 'user2'],
# 'domain' => '',
# 'server' => ['hosst1', 'host2'], }],
# gui_groups => [
# { 'class' => 'admin',
# 'perm' => [-1],
# 'desc' => "AdminGroup" }],
# }
#
# === Authors
# Michael Moll <michael.moll@noris.de>
# Jean-Denis Gebhardt <jean-denis.gebhardt@noris.de>
#
# === Copyright
# Copyright 2012 by Michael Moll
# Copyright 2014 by Jean-Denis Gebhardt
#

class dataprotector (
  $xinetd = {
    ensure => $dataprotector::params::ensure,
    ipv4   => $dataprotector::params::ipv4,
    ipv6   => $dataprotector::params::ipv6, }
  ) inherits dataprotector::params {

  package { $pkg['core']:
    ensure => 'installed',
  }

  package { $pkg['da']:
    ensure  => 'installed',
    require => Package[$pkg['core']],
  }

  file { '/var/log/omni':
    ensure  => link,
    target  => $path['log'],
    require => Package[$pkg['core']],
  }

  class { 'dataprotector::xinetd':
    ensure => $xinetd['ensure'],
    ipv4   => $xinetd['ipv4'],
    ipv6   => $xinetd['ipv6'],
  }

  augeas { 'remove5555port':
    before  => Package[$pkg['core']],
    changes =>  [
                'rm /files/etc/services/service-name[. = "personal-agent"][protocol = "tcp"]',
                'rm /files/etc/services/service-name[. = "personal-agent"][protocol = "udp"]',
                'rm /files/etc/services/service-name[. = "rplay"][protocol = "udp"]'
                ],
  }

}
