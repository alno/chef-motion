require 'spec_helper'

describe 'motion::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe package('motion') do
    it { should be_installed }
  end

  describe process('motion') do
    it { should be_running }
    its(:count) { should eq 1 }
  end

  describe file('/etc/motion/motion.conf') do
    it { should be_file }
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'motion' }
  end
end
