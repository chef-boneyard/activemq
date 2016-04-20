# make sure we have java installed
include_recipe 'java'

# Install docs instance of activemq
activemq_install 'docs' do
  version '5.12.0'
end

# Set up activemq docs instance as a service
activemq_service 'docs' do
  action [:start, :enable]
end