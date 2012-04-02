#
# Cookbook Name:: activemq
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "java"

version = node['activemq']['version']

case node[:platform]
when 'mac_os_x'
  activemq_home = "#{node['activemq']['home']}/activemq/#{version}/libexec"
  pidfile = "#{activemq_home}/data/activemq.pid"
  platform = 'macosx'
else
  activemq_home = "#{node['activemq']['home']}/apache-activemq-#{version}"
  pidfile = "/var/run/activemq.pid"
  platform = node[:platform]
end


case platform
when 'macosx'
  include_recipe 'homebrew'
  package 'activemq' do
    version version
  end
else
  tmp = Chef::Config[:file_cache_path]
  mirror = node['activemq']['mirror']

  directory node['activemq']['home'] do
    recursive true
  end

  unless File.exists?("#{activemq_home}/bin/activemq")
    remote_file "#{tmp}/apache-activemq-#{version}-bin.tar.gz" do
      source "#{mirror}/activemq/apache-activemq/#{version}/apache-activemq-#{version}-bin.tar.gz"
      mode "0644"
    end

    execute "tar zxf #{tmp}/apache-activemq-#{version}-bin.tar.gz" do
      cwd node['activemq']['home']
    end
  end

  file "#{activemq_home}/bin/activemq" do
    owner "root"
    group "root"
    mode "0755"
  end

  # TODO: make this more robust
  arch = (node['kernel']['machine'] == "x86_64") ? "x86-64" : "x86-32"

  link "/etc/init.d/activemq" do
    to "#{activemq_home}/bin/linux-#{arch}/activemq"
  end

  # symlink so the default wrapper.conf can find the native wrapper library
  link "#{activemq_home}/bin/linux" do
    to "#{activemq_home}/bin/linux-#{arch}"
  end

  # symlink the wrapper's pidfile location into /var/run
  link "/var/run/activemq.pid" do
    to "#{activemq_home}/bin/linux/ActiveMQ.pid"
    not_if "test -f /var/run/activemq.pid"
  end

end

template "#{activemq_home}/bin/#{platform}/wrapper.conf" do
  source "wrapper.conf.erb"
  mode 0644
  variables(:pidfile => pidfile,
            :platform => platform)
  notifies :restart, 'service[activemq]'
end



service "activemq" do
  supports  :restart => true, :status => true
  action [:enable, :start]
end
