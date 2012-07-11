puppet-dataprotector
====================

Puppet module to manage clients for HP Data Protector
-----------------------------------------------------

Depends on [puppetlabs-xinetd](https://github.com/puppetlabs/puppetlabs-xinetd)

Example:

     class { 'dataprotector':
       cm_ip   => '1.2.3.4',
       cm_fqdn => 'cellmanager.dom.ain'
     }

cm_ip is the IP of the cell manager.
cm_fqdn is the FQDN of the cell manager.
