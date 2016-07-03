# Puppet module to manage clients for HP Data Protector
[![Build Status](https://secure.travis-ci.org/psyco01/puppet-dataprotector.png)](http://travis-ci.org/psyco01/puppet-dataprotector)

## Example:

```puppet
  class { 'dataprotector':
    cellmanager =>  {
      address     => '1.2.3.4',
      name        => 'cellmanager.dom.ain' },
    allow_hosts => ['localhost', '10.0.0.*', '10.1.0.0/255.255.255.0'],
  }
```

* cellmanager['address'] is the IP of the cell manager.
* cellmanager['name'] is the FQDN of the cell manager.
* allow_hosts is the list of IPs, Hosts and/or Subnets allowed to access the client.
