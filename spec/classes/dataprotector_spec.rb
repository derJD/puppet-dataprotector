require 'spec_helper'

describe 'dataprotector', :type => :class do
  default_values = {
    'allow_hosts' => ['1.2.3.4', 'localhost'],
    'cellmanager' => {
      'address'    => '10.0.0.1',
      'name'       => 'hpdp.example.com'} }

  let(:facts)  { {:osfamily => 'RedHat', :concat_basedir => '/dne'} }
  let(:params) {  default_values  }
  it { should create_class('dataprotector') }
  it { should contain_class('dataprotector') }
  it { should contain_class('dataprotector::install') }
  it { should contain_class('dataprotector::config') }

  it { should contain_augeas('remove5555port') }
  it { should contain_file('/var/log/omni') }
  it { should contain_package('OB2-CORE') }
  it { should contain_package('OB2-DA') }

  context "Debian Packages" do
    let(:facts)  { {:osfamily => 'Debian', :concat_basedir => '/dne'} }
    it { should contain_package('ob2-core') }
    it { should contain_package('ob2-da') }
  end
  context "SuSE Packages" do
    let(:facts)  { {:osfamily => 'SuSE', :concat_basedir => '/dne'} }
    it { should contain_package('OB2-CORE') }
    it { should contain_package('OB2-DA') }
  end

  context "allow_hosts as array" do
    it { should contain_file('/etc/opt/omni/client/allow_hosts').with_content(/1.2.3.4/) }
    it { should contain_file('/etc/opt/omni/client/allow_hosts').with_content(/localhost/) }
  end
  [true, {}, ""].each do |e|
    context "allow_hosts as #{e.class.name}" do
      let(:params) { { 'allow_hosts' => e } }
      it { should raise_error(Puppet::Error) }
    end
  end

  context "cellmanager as hash" do
    it { should contain_file('/etc/opt/omni/client/cell_server').with_content(/#{default_values['cellmanager']['name']}/) }
    it { should contain_host("#{default_values['cellmanager']['name']}") }
  end
  [true, [], ""].each do |e|
    context "cellmanager as #{e.class.name}" do
      let(:params) { { 'cellmanager' => e } }
      it { should raise_error(Puppet::Error) }
    end
  end


end
