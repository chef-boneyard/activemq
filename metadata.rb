name             'rackspace_activemq'
maintainer       'Rackspace US Inc.'
maintainer_email 'rackspace-cookbooks@rackspace.com'
license          'Apache 2.0'
description      'Installs activemq and sets it up as service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.1'

%w(ubuntu debian redhat centos).each do |os|
  supports os
end

depends 'java', '~> 1.13'
