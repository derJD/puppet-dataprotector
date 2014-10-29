# == Class: dataprotector::server::users
#
# Manages user access for HP Data Protector GUI
# Further details in init.pp
#

class dataprotector::server::users (
  $users = $dataprotector::params::gui_users,
  $file  = "${dataprotector::params::path['server']}/users/UserList",
  ) inherits dataprotector::params {

  $_users = flatten([$gui_users, $users])

  file { $file:
    ensure  => file,
    owner   => $unix_user,
    group   => 'root',
    mode    => '0444',
    content => template("${module_name}/users.erb"),
    require => Package[$pkg['cs']],
  }
}
