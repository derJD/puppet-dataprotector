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
class dataprotector inherits dataprotector::params {

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

  augeas { 'remove5555port':
    before  => Package[$pkg['core']],
    changes =>  [
                'rm /files/etc/services/service-name[. = "personal-agent"][protocol = "tcp"]',
                'rm /files/etc/services/service-name[. = "personal-agent"][protocol = "udp"]',
                'rm /files/etc/services/service-name[. = "rplay"][protocol = "udp"]'
                ],
  }

}
