default[:idp_installer_jenkins][:github_url] = "https://github.com/canariecaf/idp-installer-CAF"
default[:idp_installer_jenkins][:v2_rel_branch] = "2.1.0-CAF"
default[:idp_installer_jenkins][:v2_dev_branch] = "develop"
default[:idp_installer_jenkins][:v3_rel_branch] = ""
default[:idp_installer_jenkins][:v3_dev_branch] = "develop-Shibv3Support"

default[:idp_installer_jenkins][:openstack_endpoint] = "http://nova-ab.dair-atir.canarie.ca:5000/v2.0"
default[:idp_installer_jenkins][:openstack_identity] = "tenant:user"
default[:idp_installer_jenkins][:openstack_credential] = "password"
default[:idp_installer_jenkins][:ubuntu1404_image] = "quebec/22f4d846-daf0-4d01-86a9-55eec35aab5d"
default[:idp_installer_jenkins][:centos6_image] = "quebec/909b2a28-184f-45da-8d60-47dbfb2f3a42"
default[:idp_installer_jenkins][:centos7_image] = "quebec/92ab167a-f28f-4ed2-9c4f-80cb397b906d"

default[:idp_installer_jenkins][:ldap_test_user] = "user"
default[:idp_installer_jenkins][:ldap_test_password] = "password"

default[:idp_installer_jenkins][:cas_test_user] = "NetID"
default[:idp_installer_jenkins][:cas_test_password] = "NetID"

default[:idp_installer_jenkins][:cas_url] = "http://cas.caf-dev.ca:8080/cas-server-webapp-3.5.2"
default[:idp_installer_jenkins][:cas_login_url] = "http://cas.caf-dev.ca:8080/cas-server-webapp-3.5.2/login"

default[:idp_installer_jenkins][:recipients] = "email@email.com"

# DO NOT CHANGE
default[:idp_installer_jenkins][:v2_cas_config] = "org.jenkinsci.plugins.configfiles.custom.CustomConfig1418080695436"
default[:idp_installer_jenkins][:v2_ldap_config] = "org.jenkinsci.plugins.configfiles.custom.CustomConfig1417550615165"
default[:idp_installer_jenkins][:v3_cas_config] = "org.jenkinsci.plugins.configfiles.custom.CustomConfig1424816375944"
default[:idp_installer_jenkins][:v3_ldap_config] = "org.jenkinsci.plugins.configfiles.custom.CustomConfig1424816405577"
