#
# Cookbook Name:: activemq
# Attributes:: default
#
# Copyright 2009-2011, Opscode, Inc.
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

default['rackspace_activemq']['mirror']  = 'http://apache.mirrors.tds.net'
default['rackspace_activemq']['version'] = '5.8.0'
default['rackspace_activemq']['home']  = '/opt'
default['rackspace_activemq']['wrapper']['max_memory'] = '1024'
default['rackspace_activemq']['wrapper']['useDedicatedTaskRunner'] = 'true'

default['rackspace_activemq']['enable_stomp'] = true
default['rackspace_activemq']['use_default_config'] = false

default['rackspace_activemq']['broker_name'] = 'localhost'
default['rackspace_activemq']['usejmx'] = false
