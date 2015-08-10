name 'activemq'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs activemq and sets it up as service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.3.5'
source_url 'https://github.com/opscode-cookbooks/activemq'
issues_url 'https://github.com/opscode-cookbooks/activemq/issues'

%w(ubuntu debian redhat centos suse scientific oracle amazon).each do |os|
  supports os
end

depends 'java', '~> 1.13'

recipe 'activemq::default', 'Installs ActiveMQ and sets it up as a service.'
