class dataprotector::client (
  $cm = {
    net  => '0.0.0.0/0',
    cell => "$:fqdn" })
  inherits dataprotector::params {

  file {
    "${path['bin']}/omnicc":
      ensure  => link,
      target  => '/bin/true',
      require => Package[$pkg['core']];
    "${path['client']}/allow_hosts":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0440',
      content => "${cm['net']}\n",
      require => Package[$pkg['core']];
    "${path['client']}/cell_server":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0440',
      content => "${cm['cell']}\n",
      require => Package[$pkg['core']],
  }
}
