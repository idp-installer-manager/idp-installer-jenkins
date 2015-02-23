default[:idp_installer_jenkins][:hosts] = {
  '205.189.33.110' => 'dc1.caftest.canarie.ca'
}

override[:apache][:listen_ports] = [ "9443" ]
