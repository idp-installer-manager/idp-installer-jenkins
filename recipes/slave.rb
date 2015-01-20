#
# Cookbook Name:: idp-installer-jenkins
# Recipe:: slave
#
# Copyright 2014, Cybera, Inc.
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apache2"

case node[:platform]
when "centos"
  include_recipe "yum"
  include_recipe "selinux::permissive"

  shib_url = "http://download.opensuse.org/repositories/security://shibboleth"
  epel_url = "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-%s&arch=x86_64"
  epel_gpgkey = "http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-%s"

  case node[:platform_version]
  when /^6/
    shib_platform = "CentOS_CentOS-6"
    epel_platform = "6"
  when /^7/
    shib_platform = "CentOS_7"
    epel_platform = "7"
  end

  yum_repository "shibboleth" do
    description "Shibboleth packages for CentOS"
    baseurl "#{shib_url}/#{shib_platform}"
    gpgkey "#{shib_url}/#{shib_platform}/repodata/repomd.xml.key"
    action :create
  end

  yum_repository "epel" do
    description "Extra packages for Enterprise Linux"
    mirrorlist epel_url % [ epel_platform ]
    gpgkey epel_gpgkey % [ epel_platform ]
    action :create
  end

  package "xorg-x11-server-Xvfb"
  package "shibboleth.x86_64"
when "ubuntu"
  execute "apt-get update"
  package "libshibsp6"
  package "shibboleth-sp2-schemas"
  package "libapache2-mod-shib2"
  package "xvfb"
end

hostsfile_entry "127.0.0.1" do
  hostname "sp.caf-dev.ca"
  aliases [ "idp.caf-dev.ca" ]
  action :append
end

node[:idp_installer_jenkins][:hosts].each do |ip,host|
  hostsfile_entry ip do
    hostname host
    action :append
  end
end

service "shibd" do
  action :enable
end

template "/etc/shibboleth/shibboleth2.xml" do
  source "shibboleth2.xml.erb"
  notifies :restart, "service[shibd]", :delayed
end

web_app "shib" do
  template "shib_site.conf.erb"
end

package "curl"
package "wget"
package "git"
package "firefox"
package "python-pip"

execute "selenium" do
  command "pip install selenium"
end
