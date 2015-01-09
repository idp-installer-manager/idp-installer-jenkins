require 'spec_helper.rb'

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

describe service('shibd') do
  it { should be_enabled }
  it { should be_running }
end
