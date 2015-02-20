require 'spec_helper'

if os[:family] == 'redhat'
  apache_dir = 'httpd'
else
  apache_dir = 'apache2'
end

describe host('sp.caf-dev.ca') do
  it { should be_resolvable }
end

describe host('idp.caf-dev.ca') do
  it { should be_resolvable }
end

describe file("/etc/#{apache_dir}/sites-enabled/shib.conf") do
  it { should be_symlink }
end

describe command('grep idp\.caf-dev\.ca /etc/shibboleth/shibboleth2.xml') do
  its(:exit_status) { should eq 0 }
end

describe command('curl -fk https://localhost:9443/Shibboleth.sso/Metadata') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /sp\.caf-dev\.ca/ }
end
