require 'spec_helper.rb'

if os[:family] == 'centos'
  shib_package = 'shibboleth.x86_64'
  xvfb_package = 'xorg-x11-server-Xvfb'
else
  shib_package = 'shibboleth-sp2-schemas'
  xvfb_package = 'xvfb'
end

describe package(shib_package) do
  it { should be_installed }
end

describe package(xvfb_package) do
  it { should be_installed }
end

describe package('git') do
  it { should be_installed }
end

describe package('firefox') do
  it { should be_installed }
end

describe package('python-pip') do
  it { should be_installed }
end

describe command('python -c "import selenium"') do
  its(:exit_status) { should eq 0 }
end
