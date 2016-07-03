# == class: dataprotector::params
#
# This module sets all default parameters
#
class dataprotector::params {
  case $::osfamily {
    'Debian': {
      $pkg = {
        'core' => 'ob2-core',
        'da'   => 'ob2-da',
        'ma'   => 'ob2-ma' }
    }
    'RedHat', 'SuSE': {
      $pkg = {
        'core' => 'OB2-CORE',
        'da'   => 'OB2-DA',
        'ma'   => 'OB2-DA' }
    }
    default: {
      fail("The ${module_name} module is not supported on ${::osfamily} based systems")
    }
  }

  $cellmanager    = {}
  $allow_hosts    = []
  $confdir        = '/etc/opt/omni/'
  $is_cellmanager = false
  $use_mediaagent = false
}
