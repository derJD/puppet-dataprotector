# == Class: dataprotector
#
# Manages clients for HP Data Protector
#
# === Parameters
#
# [*cm_ip*]
#   IP address of the cell manager (as seen from/to the client)
#
# [*cm_name*]
#   Hostname of the cell manager (as given by the CM!)
#
# === Examples
#
#  class { 'dataprotector':
#    cm_ip   => '1.2.3.4',
#    cm_name => 'cellmanager.dom.ain'
#  }
#
# === Authors
#
# Michael Moll <mmoll@mmoll.at>
#
# === Copyright
#
# Copyright 2012 by Michael Moll
#

class dataprotector ($cm_ip, $cm_name) {

  case $::osfamily {
    Debian: {
      $corepackage = 'ob2-core'
      $dapackage = 'ob2-da'
    }
    RedHat, SuSE: {
      $corepackage = 'OB2-CORE'
      $dapackage = 'OB2-DA'
    }
    default: {}
  }
  package { $corepackage:
    ensure  => 'installed'
  }
  package { $dapackage:
    ensure  => 'installed',
    require => Package[$corepackage]
  }

  file { '/var/log/omni':
    ensure => link,
    target => '/var/opt/omni/log'
  }

  host { $cm_name:
    ensure => present,
    ip     => $cm_ip,
    target => '/etc/hosts'
  }

  file { '/etc/opt/omni/client/allow_hosts':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${cm_ip}\n"
  }

  file { '/etc/opt/omni/client/cell_server':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${cm_name}\n"
  }

}
