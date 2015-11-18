# activemq Cookbook
[![Build Status](https://travis-ci.org/chef-cookbooks/activemq.svg?branch=master)](https://travis-ci.org/chef-cookbooks/activemq) [![Cookbook Version](https://img.shields.io/cookbook/v/activemq.svg)](https://supermarket.chef.io/cookbooks/activemq)

Installs Apache ActiveMQ and sets up the service using the included init script.

## Requirements
### Platforms
- Debian/Ubuntu
- RHEL/CentOS/Scientific/Amazon/Oracle

### Chef
- Chef 11+

### Cookbooks
- java

## Attributes
- `node['activemq']['mirror']` - download URL up to the activemq/apache-activemq directory.
- `node['activemq']['version']` - version to install.
- `node['activemq']['home']` - directory to deploy to (/opt by default)
- `node['activemq']['wrapper']['max_memory']` - maximum amount of memory to use for activemq.
- `node['activemq']['wrapper']['useDedicatedTaskRunner']` - whether to use the dedicated task runner
- `node['activemq']['enable_stomp']` - Flag that decides whether or not to use stomp. Note: This is only used when `use_default_config` attribute is true.
- `node['activemq']['use_default_config']` - Flag that allows the option to use a basic configuration file
- `node['activemq']['install_java']` - Whether or not to use the Java community cookbook to install Java. Defaults to `true`.
- `node['activemq']['enabled']` - Whether or not the ActiveMQ service should be started.  Defaults to `true`.

## Usage
Simply add `recipe[activemq]` to a run list.

## License & Authors
**Author:** Cookbook Engineering Team ([cookbooks@chef.io](mailto:cookbooks@chef.io))

**Copyright:** 2008-2015, Chef Software, Inc.

```
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
