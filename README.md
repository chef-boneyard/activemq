rackspace_activemq Cookbook
=================

Installs activemq and sets up a service using the init script that comes with it.


Requirements
------------
### activemq Versions
activemq.xml template (if using use_default_config attribute) only supports activemq versions higher than 5.5.1. 

### Platforms
Should work on any Debian or Red Hat family distributions.

### Cookbooks
- java


Attributes
----------
- `node['rackspace_activemq']['mirror']` - download URL up to the activemq/apache-activemq directory.
- `node['rackspace_activemq']['version']` - version to install.
- `node['rackspace_activemq']['home']` - directory to deploy to (/opt by default)
- `node['rackspace_activemq']['wrapper']['max_memory']` - maximum amount of memory to use for activemq.
- `node['rackspace_activemq']['wrapper']['useDedicatedTaskRunner']` - whether to use the dedicated task runner
- `node['rackspace_activemq']['enable_stomp']` - Flag that decides whether or not to use stomp. Note: This is
only used when `use_default_config` attribute is true.
- `node['rackspace_activemq']['use_default_config']` - Flag that allows the option to use a basic configuration file
- `node['rackspace_activemq']['broker_name']` - Flag that allows you to set the broker name.
- `node['rackspace_activemq']['usejmx']` - Flag that allows you to enable jmx support.


Usage
-----
Simply add `recipe[rackspace_activemq]` to a run list.


License & Authors
-----------------
- Author:: Joshua Timberman (<joshua@opscode.com>)

```text
Copyright:: 2009-2011, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
