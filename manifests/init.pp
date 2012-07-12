# == Class: dataprotector
#
# Manages clients for HP Data Protector
#
# === Parameters
#
# [*cm_ip*]
#   IP address of the cell manager (as seen from/to the client)
#
# [*cm_fqdn*]
#   FQDN of the cell manager
#
# === Examples
#
#  class { 'dataprotector':
#    cm_ip   => '1.2.3.4',
#    cm_fqdn => 'cellmanager.dom.ain'
#  }
#
# === Authors
#
# Michael Moll <kvedulv@kvedulv.de>
#
# === Copyright
#
# Copyright 2012 by Michael Moll
#

class dataprotector ($cm_ip, $cm_fqdn) {

  service { 'xinetd':
    ensure => 'running',
    enable => true
  }

  xinetd::service { 'omni':
    port        => '5555',
    server      => '/opt/omni/lbin/inet',
    server_args => 'inet -log /var/opt/omni/log/inet.log',
    flags       => 'IPv4'
  }

  case $::osfamily {
    Debian: {
      $packages = [ob2-core, ob2-da]
    }
    RedHat: {
      $packages = [OB2-CORE, OB2-DA]
    }
    default: {}
  }
    package { $packages:
    ensure  => 'installed'
  }

  file { '/var/log/omni':
    ensure => link,
    target => '/var/opt/omni/log'
  }

  host { $cm_fqdn:
    ensure       => present,
    ip           => $cm_ip,
    host_aliases => inline_template('<%= cm_fqdn.split(".")[0] %>'),
    target       => '/etc/hosts'
  }

  file { '/etc/opt/omni/client/allow_hosts':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "$cm_ip\n"
  }

}
