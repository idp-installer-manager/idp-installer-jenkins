require 'spec_helper.rb'

if os[:family] == 'centos'
  apache_service = 'httpd'
else
  apache_service = 'apache2'
end

describe service(apache_service) do
  it { should be_enabled }
  it { should be_running }
end

describe service('shibd') do
  it { should be_enabled }
  it { should be_running }
end
