if defined?(ChefSpec)
  #################
  # activemq_install
  #################
  ChefSpec.define_matcher :activemq_install

  def install_activemq_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:activemq_install, :install, resource_name)
  end
end