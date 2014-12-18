name             'idp-installer-jenkins'
maintainer       'Cybera, Inc.'
maintainer_email 'cameron.mann@cybera.ca'
license          'All rights reserved'
description      'Installs and configures Jenkins for use with the IdP installer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apache2"
depends "jenkins"
