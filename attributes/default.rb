default[:idp_installer_jenkins][:github_url] = "https://github.com/canariecaf/idp-installer-CAF"

default[:idp_installer_jenkins][:openstack_endpoint] = "http://nova-ab.dair-atir.canarie.ca:5000/v2.0"
default[:idp_installer_jenkins][:openstack_identity] = "tenant:user"
default[:idp_installer_jenkins][:openstack_credential] = "password"
default[:idp_installer_jenkins][:ubuntu1404_image] = "quebec/693857fe-8e69-4994-bcb5-cd2a9b385486"
default[:idp_installer_jenkins][:centos7_image] = "quebec/93228e20-3e8e-43d5-a33a-dcb729cdaf3b"
default[:idp_installer_jenkins][:centos7_image] = "quebec/d2c23e93-ed02-4b64-a76a-a90e4283571a"

default[:idp_installer_jenkins][:ldap_test_user] = "user"
default[:idp_installer_jenkins][:ldap_test_password] = "password"

default[:idp_installer_jenkins][:cas_url] = "http://cas.caf-dev.ca:8080/cas-server-webapp-3.5.2"
default[:idp_installer_jenkins][:cas_login_url] = "http://cas.caf-dev.ca:8080/cas-server-webapp-3.5.2/login"

default[:idp_installer_jenkins][:recipients] = "email@email.com"
