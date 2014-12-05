# == Class: dataprotector::client
#
# Manages servers for HP Data Protector
# Further details in init.pp
#

class dataprotector::server (
  $unix_user   = $dataprotector::params::unix_user,
  $unix_group  = $dataprotector::params::unix_group,
  $gui_users   = $dataprotector::params::gui_users,
  $gui_groups  = $dataprotector::params::gui_groups,
  $shares  = {
    src     => undef,
    dst     => undef,
    options => undef },
  $ma_only = false,
  ) inherits dataprotector::params {

  if ($ma_only == true) {
    package { $pkg['ma']:
      ensure  => 'installed',
      require => Package[$pkg['core']],
    }
  } else {
    package { [$pkg['cs'], $pkg['cc'], $pkg['ma']]:
      ensure  => 'installed',
      require => Package[$pkg['core']],
    }

    user { $unix_user:
      ensure => 'present',
      shell  => '/sbin/bash',
      home   => '/opt/omni',
      before => Package[$pkg['core']],
    }
  
    group { $unix_group:
      ensure => 'present',
      before => Package[$pkg['core']],
    }

    class { 'dataprotector::server::users':
      users => $gui_users,
    }

    class { 'dataprotector::server::groups':
      groups => $gui_groups,
    }
  }

  if ($shares['dst'] != undef) or ($shares['dst'] != undef) {
    file { $shares['dst']:
      ensure => directory,
      owner  => $unix_user,
      group  => $unix_group,
      mode   => '0775',
      before => Package[$pkg['core']],
    }

    mount { $shares['dst']:
      ensure  => 'mounted',
      device  => $shares['src'],
      options => $shares['options'],
      atboot  => true,
      require => File[$shares['dst']],
      before  => Package[$pkg['core']],
    }
  }

  file { '/etc/profile.d/omni.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "export PATH=\$PATH:/opt/omni/bin:/opt/omni/lbin:/opt/omni/sbin\n",
    require => Package[$pkg['cc']],
  }
}
