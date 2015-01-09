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
jenkins_plugin "jclouds-jenkins"

template "/var/lib/jenkins/config.xml" do
  source "jenkins_config.xml.erb"
end

template "/var/lib/jenkins/custom-config-files.xml" do
  source "custom_config_files.xml.erb"
end

%w{ cas ldap }.each do |job|
  job_config = File.join(Chef::Config[:file_cache_path], "#{job}_config.xml")

  template job_config do
    source "job_config.xml.erb"
    variables :partials => {
      :builders => "#{job}_builders.xml.erb"
    }
  end

  jenkins_job "idp-installer-#{job}" do
    config job_config
  end
end
