name 'activemq'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs activemq and sets it up as service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '4.0.2'

recipe 'activemq::default', 'Installs Apache ActiveMQ and sets up the service using the included init script.'

%w(ubuntu debian redhat centos suse opensuse opensuseleap scientific oracle amazon).each do |os|
  supports os
end

depends 'java', '~> 1.13'

source_url 'https://github.com/chef-cookbooks/activemq'
issues_url 'https://github.com/chef-cookbooks/activemq/issues'
chef_version '>= 12.5' if respond_to?(:chef_version)
