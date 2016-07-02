source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "= #{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 3.4']
end

gem 'rake'
gem 'rspec-core'
gem 'puppetlabs_spec_helper'
gem 'puppet-lint'
gem 'puppet-lint-absolute_template_path'
gem 'puppet-lint-variable_contains_upcase'
gem 'puppet', puppetversion
gem 'metadata-json-lint'
