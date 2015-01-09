require 'spec_helper'

describe file('/var/lib/jenkins/custom-config-files.xml') do
  it { should be_file }
end

describe file('/var/lib/jenkins/jobs/idp-installer-cas/config.xml') do
  it { should be_file }
end

describe file('/var/lib/jenkins/jobs/idp-installer-ldap/config.xml') do
  it { should be_file }
end

describe command('grep jclouds /var/lib/jenkins/config.xml') do
 its(:exit_status) { should eq 0 }
end
