require 'spec_helper'

describe 'dataprotector', :type => :class do
  let(:facts)  { {:osfamily => 'Debian', :concat_basedir => '/dne'} }
  let(:params) { {
    :cm_ip   => '10.0.0.1',
    :cm_name => 'hpdp.example.com' } }
  it { should create_class('dataprotector') }
  it { should contain_class('dataprotector') }
  #it { should contain_class('dataprotector::install').that_comes_before('Class[dataprotector::config]') }
end
