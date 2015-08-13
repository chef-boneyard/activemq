name 'activemq'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs activemq and sets it up as service'
version '1.3.5'

%w(ubuntu debian redhat centos suse scientific oracle amazon).each do |os|
  supports os
end

depends 'java', '~> 1.13'

source_url 'https://github.com/opscode-cookbooks/activemq' if respond_to?(:source_url)
issues_url 'https://github.com/opscode-cookbooks/activemq/issues' if respond_to?(:source_url)
