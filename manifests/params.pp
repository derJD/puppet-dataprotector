# == Class: dataprotector::params
#
# Class containing all parameters.
#

class dataprotector::params {

  $ensure     = 'present'
  $unix_user  = 'hpdp'
  $unix_group = 'hpdp'

  if ($::ipaddress != undef) {
    $ipv4 = true
  } else {
    $ipv4 = false
  }

  if ($::ipaddress6 != undef) {
    $ipv6 = true
  } else {
    $ipv6 = false
  }

  $path = {
    bin    => '/opt/omni/bin/',
    log    => '/var/opt/omni/log/',
    client => '/etc/opt/omni/client/',
    server => '/etc/opt/omni/server/',
    xinetd => '/etc/xinetd.d/omni',
  }

  case $::osfamily {
    Debian: {
      $pkg = {
        da   => 'ob2-da',
        core => 'ob2-core',
      }
    }
    RedHat, SuSE: {
      $pkg = {
        cs   => 'OB2-CS',
        cc   => 'OB2-CC',
        da   => 'OB2-DA',
        ma   => 'OB2-MA',
        core => 'OB2-CORE',
      }
    }
    default: {fail("There are currently no defaultvalues for packages on ${::osfamily}")}
  }

  $gui_users = [
    { 'group'  => 'admin',
      'user'   => ['root', $unix_user],
      'domain' => '',
      'server' => [$::fqdn]},
    { 'group'  => 'admin',
      'user'   => ['java'],
      'domain' => 'applet',
      'server' => ['webreporting']},
  ]

  $gui_groups = [
    { 'class' => 'admin',
      'perm'  => [-1],
      'desc'  => 'Admins' },
    { 'class' => 'operator',
      'perm'  => [2,7,1,3,4,3],
      'desc'  => 'Operators' },
    { 'class' => 'user',
      'perm'  => [3,2],
      'desc'  => 'users' },
  ]
}
