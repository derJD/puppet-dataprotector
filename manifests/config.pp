# == class: dataprotector::config
#
# This module is setting up basic configuration
#
class dataprotector::config inherits dataprotector {

  $cellmanager = $::dataprotector::cellmanager
  $allow_hosts = $::dataprotector::allow_hosts
  $confdir     = $::dataprotector::confdir
  $pkg         = $::dataprotector::params::pkg

  augeas { 'remove5555port':
    before  => Package[$pkg['core']],
    context => '/files/etc/services',
    changes =>  [
                'rm service-name[. = "personal-agent"][protocol = "tcp"]',
                'rm service-name[. = "personal-agent"][protocol = "udp"]',
                'rm service-name[. = "rplay"][protocol = "udp"]'
                ],
  }

  file { '/var/log/omni':
    ensure  => link,
    target  => '/var/opt/omni/log',
    require => Package[$pkg['core']],
  }

  host { $cellmanager['name']:
    ensure => present,
    ip     => $cellmanager['address'],
  }

  file { "${confdir}client/allow_hosts":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/allow_hosts.erb"),
    require => Package[$pkg['core']],
  }

  file { "${confdir}client/cell_server":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/cell_server.erb"),
    require => Package[$pkg['core']],
  }
}
