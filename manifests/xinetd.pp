# == Class: dataprotector::xinetd
#
# Manages xinetd for HP Data Protector
# Further details in init.pp
#

class dataprotector::xinetd (
  $ipv4   = $dataprotector::params::ipv4,
  $ipv6   = $dataprotector::params::ipv6,
  $ensure = $dataprotector::params::ensure,)
  inherits dataprotector::params {

  case $ensure {
    present, absent: {
      notice("${::class_name} is ${ensure}")
    }
    default: {
      fail("${ensure} not supported! Valid values: present, absent.")
    }
  }

  if ($ensure == 'present') {
    package {'xinetd':
      ensure => present,
    }

    service {'xinetd':
      ensure     => running,
      enable     => true,
      hasrestart => false,
      hasstatus  => false,
      require    => Package[xinetd],
    }

    file { $path['xinetd']:
      ensure => absent,
    }

    if ($ipv4 == true) {
      dataprotector::omni { 'ipv4': }
    }

    if ($ipv6 == true) {
      dataprotector::omni { 'ipv6': }
    }
  }
}
