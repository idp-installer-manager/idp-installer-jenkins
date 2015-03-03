require 'spec_helper'

describe file('/var/lib/jenkins/custom-config-files.xml') do
  it { should be_file }
end

describe command('grep jclouds /var/lib/jenkins/config.xml') do
 its(:exit_status) { should eq 0 }
end

describe command('wget -qO- localhost') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /Dashboard \[Jenkins\]/ }
end
