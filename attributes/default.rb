default[:idp_installer_jenkins][:github_url] = "https://github.com/canariecaf/idp-installer-CAF"

default[:idp_installer_jenkins][:openstack_endpoint] = "http://nova-ab.dair-atir.canarie.ca:5000/v2.0"
default[:idp_installer_jenkins][:openstack_identity] = "tenant:user"
default[:idp_installer_jenkins][:openstack_credential] = "password"
default[:idp_installer_jenkins][:centos6_image] = "quebec/c3bfbe78-e59e-4767-b940-0da021f4a064"
default[:idp_installer_jenkins][:centos7_image] = "quebec/93228e20-3e8e-43d5-a33a-dcb729cdaf3b"

default[:idp_installer_jenkins][:ldap_test_user] = "user"
default[:idp_installer_jenkins][:ldap_test_password] = "password"

default[:idp_installer_jenkins][:cas_url] = "http://cas.caf-dev.ca:8080/cas-server-webapp-3.5.2"
default[:idp_installer_jenkins][:cas_login_url] = "http://cas.caf-dev.ca:8080/cas-server-webapp-3.5.2/login"

default[:idp_installer_jenkins][:recipients] = "email@email.com"
