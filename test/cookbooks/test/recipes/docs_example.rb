# make sure we have java installed
include_recipe 'java'

# Install activemq
activemq_install 'docs' do
  version '5.12.0'
end
