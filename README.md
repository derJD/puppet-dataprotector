# Puppet module to manage clients for HP Data Protector
[![Build Status](https://secure.travis-ci.org/mmoll/puppet-dataprotector.png)](http://travis-ci.org/mmoll/puppet-dataprotector)

## Example:

```
  class { 'dataprotector':
    cm_ip   => '1.2.3.4',
    cm_name => 'cellmanager.dom.ain'
  }
```

* cm_ip is the IP of the cell manager.
* cm_name is the FQDN of the cell manager.
