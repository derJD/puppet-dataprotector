define dataprotector::omni {
  file { "${dataprotector::params::path['xinetd']}_${name}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template("${module_name}/omni.erb"),
    notify  => Service[xinetd],
  }
}
