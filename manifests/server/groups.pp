class dataprotector::server::groups (
  $groups = $dataprotector::params::gui_groups,
  $file   = "${path['server']}/users/CassSpec",
  ) inherits dataprotector::params {

  $_groups = flatten([$gui_groups, $groups])

  file { "$file":
    ensure  => file,
    owner   => $unix_users,
    group   => 'root',
    mode    => '0444',
    content => template("${module_name}/groups.erb"),
    require => Package[$pkg['cs']],
  }
}
