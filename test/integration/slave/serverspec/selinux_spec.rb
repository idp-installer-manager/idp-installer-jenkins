require 'spec_helper'

describe selinux, :if => os[:family] == 'redhat' do
  it { should be_permissive }
end
