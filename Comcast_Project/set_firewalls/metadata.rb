name             'set_firewalls'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures set_firewalls'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'selinux', '~> 0.9.0'
depends 'firewall', '~> 2.4.0'
