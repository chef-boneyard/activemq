node.default['activemq']['use_default_config'] = true

# make sure we have an updated package cache on debian/ubuntu
apt_update 'update' if platform_family?('debian')

# make sure we have java installed
include_recipe 'java'

# run the legacy default recipe
include_recipe 'activemq::default'
