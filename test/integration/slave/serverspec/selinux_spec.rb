require 'spec_helper'

describe selinux, :if => os[:family] == 'centos' do
  it { should be_permissive }
end
