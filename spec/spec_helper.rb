require 'serverspec'
require 'pathname'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/server'

ChefSpec::Coverage.start! do
 add_filter 'vendor/cookbooks'
end
