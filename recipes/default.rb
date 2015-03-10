#
# Cookbook Name:: idp-installer-jenkins
# Recipe:: default
#
include_recipe "apache2"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"

if node[:platform] == "centos"
  include_recipe "selinux::permissive"
  package "java-1.7.0-openjdk.x86_64"
end

package "git"

include_recipe "jenkins::master"
jenkins_plugin "github"
jenkins_plugin "config-file-provider"
jenkins_plugin "jclouds-jenkins"
jenkins_command "safe-restart"

web_app "jenkins" do
  template "jenkins_site.conf.erb"
end

template "/var/lib/jenkins/config.xml" do
  source "jenkins_config.xml.erb"
end

template "/var/lib/jenkins/custom-config-files.xml" do
  source "custom_config_files.xml.erb"
end

%w{ v2 v3 }.each do |version|
  %w{ cas ldap }.each do |auth|
    %w{ rel dev }.each do |branch|
      job = "#{version}_#{auth}_#{branch}"
      git_branch = node[:idp_installer_jenkins]["#{version}_#{branch}_branch"]
      config_id = node[:idp_installer_jenkins]["#{version}_#{auth}_config"]

      if git_branch == ""
        next
      end

      job_config = File.join(Chef::Config[:file_cache_path], "#{job}_config.xml")

      #
      # If release and develop builders ever start to differ, use #{job}
      # instead of #{version}_#{auth} and rename templates accordingly.
      #
      template job_config do
        source "job_config.xml.erb"
        variables(
          :partials => {
            :builders => "#{version}_#{auth}_builders.xml.erb",
            :triggers => "#{branch}_triggers.xml.erb"
          },
          :git_branch => git_branch,
          :config_id => config_id
        )
      end

      jenkins_job job do
        config job_config
      end
    end
  end
end
