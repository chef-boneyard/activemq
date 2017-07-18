apt_update 'update' if platform_family?('debian')

# make sure we have java installed
include_recipe 'java'

activemq_install 'main_queue'
