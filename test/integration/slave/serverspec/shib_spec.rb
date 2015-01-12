require 'spec_helper'

if os[:family] == 'centos'
  apache_dir = 'httpd'
else
  apache_dir = 'apache2'
end

describe host('sp.caf-dev') do
  it { should be_resolvable }
end

describe host('idp.caf-dev') do
  it { should be_resolvable }
end

describe file("/etc/#{apache_dir}/sites-enabled/shib.conf") do
  it { should be_symlink }
end

describe command('grep idp\.caf-dev /etc/shibboleth/shibboleth2.xml') do
  its(:exit_status) { should eq 0 }
end

describe command('curl -f localhost/Shibboleth.sso/Metadata') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /sp\.caf-dev/ }
end
