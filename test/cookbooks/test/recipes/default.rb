apt_update

# make sure we have java installed
include_recipe 'java'

activemq_install 'main_queue'
