activemq Cookbook
=================

[![Build Status](https://travis-ci.org/opscode-cookbooks/activemq.svg?branch=master)](https://travis-ci.org/opscode-cookbooks/activemq)
[![Cookbook Version](https://img.shields.io/cookbook/v/activemq.svg)](https://supermarket.chef.io/cookbooks/activemq)

Installs Apache ActiveMQ and sets up the service using the included init script.


Requirements
------------
### Platforms
- Debian/Ubuntu
- RHEL/CentOS/Scientific/Amazon/Oracle

### Chef
Chef 11+

### Cookbooks
- java


Attributes
----------
- `node['activemq']['mirror']` - download URL up to the activemq/apache-activemq directory.
- `node['activemq']['version']` - version to install.
- `node['activemq']['home']` - directory to deploy to (/opt by default)
- `node['activemq']['wrapper']['max_memory']` - maximum amount of memory to use for activemq.
- `node['activemq']['wrapper']['useDedicatedTaskRunner']` - whether to use the dedicated task runner
- `node['activemq']['enable_stomp']` - Flag that decides whether or not to use stomp. Note: This is
only used when `use_default_config` attribute is true.
- `node['activemq']['use_default_config']` - Flag that allows the option to use a basic configuration file
- `node['activemq']['install_java']` - Whether or not to use the Java community cookbook to install Java. Defaults to `true`.
- `node['activemq']['enabled']` - Whether or not the ActiveMQ service should be started.  Defaults to `true`.


Usage
-----
Simply add `recipe[activemq]` to a run list.


Development
-----------
This section details "quick development" steps. For a detailed explanation, see [[Contributing.md]].

1. Clone this repository from GitHub:

        $ git clone git@github.com:opscode-cookbooks/activemq.git

2. Create a git branch

        $ git checkout -b my_bug_fix

3. Install dependencies:

        $ bundle install

4. Make your changes/patches/fixes, committing appropiately
5. **Write tests**
6. Run the tests:
    - `bundle exec foodcritic -f any .`
    - `bundle exec rspec`
    - `bundle exec rubocop`
    - `bundle exec kitchen test`

  In detail:
    - Foodcritic will catch any Chef-specific style errors
    - RSpec will run the unit tests
    - Rubocop will check for Ruby-specific style errors
    - Test Kitchen will run and converge the recipes


License & Authors
-----------------
- Author:: Joshua Timberman (<joshua@chef.io>)

```text
Copyright:: 2009-2015, Chef Software, Inc

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
