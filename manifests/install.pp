# == class: dataprotector::install
#
# This module is installing basic packages
#
class dataprotector::install {
  $pkg = $::dataprotector::params::pkg

  package { $pkg['core']:
    ensure  => 'installed',
  }

  package { $pkg['da']:
    ensure  => 'installed',
    require => Package[$pkg['core']],
  }
}
