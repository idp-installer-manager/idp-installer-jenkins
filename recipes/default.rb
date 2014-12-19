#
# Cookbook Name:: idp-installer-jenkins
# Recipe:: default
#
# Copyright 2014, Cybera, Inc.
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apache2"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"
include_recipe "jenkins::master"

web_app "jenkins" do
  template "jenkins_site.conf.erb"
end

jenkins_plugin "github"
jenkins_plugin "config-file-provider"

ldap_config = File.join(Chef::Config[:file_cache_path], 'ldap_config.xml')
template ldap_config do
  source "config.xml.erb"
  variables :partials => {
    :builders => "ldap_builders.xml.erb"
  }
end

cas_config = File.join(Chef::Config[:file_cache_path], 'cas_config.xml')
template cas_config do
  source "config.xml.erb"
  variables :partials => {
    :builders => "cas_builders.xml.erb"
  }
end

jenkins_job "idp-installer-ldap" do
  config ldap_config
end

jenkins_job "idp-installer-cas" do
  config cas_config
end
