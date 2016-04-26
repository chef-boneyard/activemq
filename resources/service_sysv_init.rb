provides :activemq_service, platform_family: 'suse'
provides :activemq_service, platform: 'amazon'

provides :activemq_service, platform: %w(redhat centos scientific oracle) do |node| # ~FC005
  node['platform_version'].to_f < 7.0
end

provides :activemq_service, platform: 'debian' do |node|
  node['platform_version'].to_i < 8
end

property :instance_name, String, name_property: true
property :install_path, String
property :env_vars, Array

action :start do
  create_init

  service "activemq_#{new_resource.instance_name}" do
    supports restart: true, status: true
    action :start
  end
end

action :stop do
  service "activemq_#{new_resource.instance_name}" do
    supports status: true
    action :stop
    only_if { ::File.exist?("/etc/init.d/activemq_#{new_resource.instance_name}") }
  end
end

action :restart do
  action_stop
  action_start
end

action :enable do
  create_init

  service "activemq_#{new_resource.instance_name}" do
    supports status: true
    action :enable
    only_if { ::File.exist?("/etc/init.d/activemq_#{new_resource.instance_name}") }
  end
end

action :disable do
  service "activemq_#{new_resource.instance_name}" do
    supports status: true
    action :disable
    only_if { ::File.exist?("/etc/init.d/activemq_#{new_resource.instance_name}") }
  end
end

action_class do
  def create_init
    template "/etc/default/activemq-instance-#{new_resource.instance_name}" do
      source 'env.erb'
      cookbook 'activemq'
      owner 'root'
      group 'root'
      mode '0655'
    end

    template "/etc/init.d/activemq_#{new_resource.instance_name}" do
      source 'init_sysv.erb'
      variables(
        install_path: derived_install_path
      )
      cookbook 'activemq'
      owner 'root'
      group 'root'
      mode '0655'
    end
  end
end
