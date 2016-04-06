include_recipe 'java::default'

activemq_install 'test_instance' do
  version '5.13.2'
end
