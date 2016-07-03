require 'spec_helper'

describe 'dataprotector::params', :type => :class do
  let(:facts) { {:osfamily => 'RedHat', :concat_basedir => '/dne'} }
  it { should create_class('dataprotector::params') }
end
