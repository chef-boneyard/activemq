if defined?(ChefSpec)
  #################
  # activemq_install
  #################
  ChefSpec.define_matcher :activemq_install

  def install_activemq_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:activemq_install, :install, resource_name)
  end

  ################
  # activemq_service
  ################
  ChefSpec.define_matcher :activemq_service

  def start_activemq_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:activemq_service, :start, resource_name)
  end

  def enable_activemq_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:activemq_service, :enable, resource_name)
  end

  def restart_activemq_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:activemq_service, :restart, resource_name)
  end

  def stop_activemq_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:activemq_service, :stop, resource_name)
  end

  def disable_activemq_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:activemq_service, :disable, resource_name)
  end
end
