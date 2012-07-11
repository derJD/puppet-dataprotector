class dataprotector ($cm_ip, $cm_fqdn) {

  service { 'xinetd':
    ensure => 'running',
    enable => true
  }

  xinetd::service { 'omni':
    port        => '5555',
    server      => '/opt/omni/lbin/inet',
    server_args => 'inet -log /var/opt/omni/log/inet.log',
    flags       => 'IPv4'
  }

  package { '[ob2-core, ob2-da]':
    ensure  => 'installed'
  }

  file { '/var/log/omni':
    ensure => link,
    target => '/var/opt/omni/log'
  }

  host { $cm_fqdn:
    ensure       => present,
    ip           => $cm_ip,
    host_aliases => inline_template('<%= cm_fqdn.split(".")[0] %>'),
    target       => '/etc/hosts'
  }

  file { '/etc/opt/omni/client/allow_hosts':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "$cm_ip\n"
  }

}
