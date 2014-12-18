default[:idp_installer_jenkins][:ldap_host] = "ad.shibtest.cybera.ca"
default[:idp_installer_jenkins][:ldap_ip] = "10.1.1.38"
default[:idp_installer_jenkins][:ldap_bind_dn] = "CN=user A,OU=Test,DC=shibtest,DC=cybera,DC=ca"
default[:idp_installer_jenkins][:ldap_password] = "password"
default[:idp_installer_jenkins][:ldap_base_dn] = "OU=Test,DC=shibtest,DC=cybera,DC=ca"
default[:idp_installer_jenkins][:ldap_test_user] = "usera"
default[:idp_installer_jenkins][:ldap_test_password] = "password"

default[:idp_installer_jenkins][:cas_host] = "cas.shibtest.cybera.ca"
default[:idp_installer_jenkins][:cas_ip] = "10.1.1.57"
default[:idp_installer_jenkins][:cas_url] = "http://#{default[:idp_installer_jenkins][:cas_host]}:8080/cas-server-webapp-3.5.2"
default[:idp_installer_jenkins][:cas_login_url] = "http://#{default[:idp_installer_jenkins][:cas_host]}:8080/cas-server-webapp-3.5.2/login"

default[:idp_installer_jenkins][:recipients] = "cameron.mann@cybera.ca"
