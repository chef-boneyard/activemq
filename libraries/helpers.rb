
module ActivemqCookbook
  module Helpers
    include Chef::DSL::IncludeRecipe

    def activemq_version
      new_resource.version || '5.12.0'
    end

    def activemq_home
      new_resource.home || 'opt'
    end

    def activemq_mirror
      new_resource.mirror || 'https://repository.apache.org/content/repositories/releases/org/apache'
    end

    def activemq_user
      new_resource.user || 'root'
    end

    def activemq_group
      new_resource.group || 'root'
    end

    def activemq_default_config
      new_resource.default_config || false
    end

    def activemq_arch
      node['kernel']['machine'] == 'x86_64' ? 'x86-64' : 'x86-32'
    end

    def activemq_enabled
      new_resource.enabled || true
    end
  end
end