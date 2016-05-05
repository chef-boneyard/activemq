provides :activemq_service, platform: 'ubuntu' do |node|
  node['platform_version'].to_f < 15.10
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
    only_if { ::File.exist?("/etc/init/activemq_#{new_resource.instance_name}.conf") }
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
    only_if { ::File.exist?("/etc/init/activemq_#{new_resource.instance_name}.conf") }
  end
end

action :disable do
  service "activemq_#{new_resource.instance_name}" do
    supports status: true
    action :disable
    only_if { ::File.exist?("/etc/init/activemq_#{new_resource.instance_name}.conf") }
  end
end

action_class do
  def create_init
    template "/etc/init/activemq_#{new_resource.instance_name}.conf" do
      source 'init_upstart.erb'
      variables(
        instance: new_resource.instance_name,
        env_vars: new_resource.env_vars,
        install_path: derived_install_path
      )
      cookbook 'activemq'
      owner 'root'
      group 'root'
      mode '0644'
    end
  end
end
