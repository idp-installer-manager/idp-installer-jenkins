default[:idp_installer_jenkins][:github_url] = "https://github.com/cybera/idp-installer-CAF"

default[:idp_installer_jenkins][:openstack_endpoint] = "https://keystone-yyc.cloud.cybera.ca:5000/v2.0"
default[:idp_installer_jenkins][:centos6_image] = "Calgary/af856c02-29f7-4f5e-a504-5a677d63923e"
default[:idp_installer_jenkins][:centos7_image] = "Calgary/05b3a265-1e90-4d0b-b14e-a910cd1fdfc8"

default[:idp_installer_jenkins][:ldap_test_user] = "user"
default[:idp_installer_jenkins][:ldap_test_password] = "password"

default[:idp_installer_jenkins][:cas_url] = "http://cas-server.com:8080/cas-server-webapp-3.5.2"
default[:idp_installer_jenkins][:cas_login_url] = "http://cas-server.com:8080/cas-server-webapp-3.5.2/login"

default[:idp_installer_jenkins][:recipients] = "cameron.mann@cybera.ca"

default[:idp_installer_jenkins][:sp_port] = 9443
