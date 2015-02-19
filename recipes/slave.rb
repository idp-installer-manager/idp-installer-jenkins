#
# Cookbook Name:: idp-installer-jenkins
# Recipe:: slave
#
# Copyright 2014, Cybera, Inc.
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apache2"
include_recipe "apache2::mod_ssl"

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
  
  cert_path = "/etc/pki/tls/certs/ssl-cert-snakeoil.pem"
  key_path = "/etc/pki/tls/private/ssl-cert-snakeoil.key"

  if not File.exist?(cert_path)
    execute "/etc/pki/tls/certs/make-dummy-cert dummy"
    execute "csplit dummy /^$/"
    execute "mv xx00 #{key_path}"
    execute "mv xx01 #{cert_path}"
    execute "rm -f dummy"
  end
when "ubuntu"
  execute "apt-get update"
  package "libshibsp6"
  package "shibboleth-sp2-schemas"
  package "libapache2-mod-shib2"
  package "xvfb"

  if not File.exist?("/etc/shibboleth/sp-cert.pem")
    execute "shib-keygen"
  end

  cert_path = "/etc/ssl/certs/ssl-cert-snakeoil.pem"
  key_path = "/etc/ssl/private/ssl-cert-snakeoil.key"

  if not File.exist?(cert_path)
    execute "make-ssl-cert generate-default-snakeoil --force-overwrite"
  end
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
  cert_path cert_path
  key_path key_path
end

package "curl"
package "wget"
package "git"
package "firefox"
package "python-pip"

execute "pip install selenium"
