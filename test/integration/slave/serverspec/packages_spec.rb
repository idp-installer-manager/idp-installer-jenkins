require 'spec_helper.rb'

describe package('shibboleth.x86_64') do
  it { should be_installed }
end

describe package('xorg-x11-server-Xvfb') do
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
