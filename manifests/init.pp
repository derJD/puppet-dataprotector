# == Class: dataprotector
#
# Manages clients for HP Data Protector
#
# === Parameters
#
# [*cellmanager*]
#   Hash for IP address (address) and Hostname (name) of the cell manager (as seen from/to the client)
#
# [*allowed_hosts*]
#   Array of allowed hosts/subnets accessing this client
#
# === Examples
#
#  class { 'dataprotector':
#    cellmanager =>  {
#      address     => '1.2.3.4',
#      name        => 'cellmanager.dom.ain' },
#    allow_hosts => ['localhost', '10.0.0.*', '10.1.0.0/255.255.255.0'],
#  }
#
# === Authors
#
# Michael Moll <mmoll@mmoll.at>
# Jean-Denis Gebhardt <jd@der-jd.de>
#
# === Copyright
#
# Copyright 2016 by Jean-Denis Gebhardt
#
class dataprotector (
  $confdir        = $::dataprotector::params::confdir,
  $cellmanager    = $::dataprotector::params::cellmanager,
  $allow_hosts    = $::dataprotector::params::allow_hosts,
  $is_cellmanager = $::dataprotector::params::is_dataprotector,
  $use_mediaagent = $::dataprotector::params::use_mediaagent,
) inherits dataprotector::params {

  if ($confdir)     { validate_string($confdir) }
  if ($allow_hosts) { validate_array($allow_hosts) }
  if ($cellmanager) { validate_hash($cellmanager) }
  if ($is_cellmanager) { validate_bool($is_cellmanager) }
  if ($use_mediaagent) { validate_bool($use_mediaagent) }

  class {'dataprotector::install': }
  class {'dataprotector::config':  }
}
