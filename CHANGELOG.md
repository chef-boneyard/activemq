# activemq Cookbook CHANGELOG

This file is used to list changes made in each version of the activemq cookbook.

## 4.0.0 (2017-02-27)

- Move templates to the root dir since Chef 12 allows this`
- Remove platform check that isn’t necessary anymore
- Fix a deprecation warning in the test cookbook
- Require 12.5+ and remove compat_resource dependency

## 3.0.1 (2016-12-22)
- Require compat_resource
- Remove LWRP-isms from the custom resource
- Cookstyle fixes

## 3.0.0 (2016-09-19)

- Require Chef 12.1 or later
- Switch testing in Travis to kitchen-dokken for integration testing and our Rakefile with cookstyle, foodcritic, and chefspec for linting/unit testing
- Switched integration testing from Serverspec to Inspec
- Add activemq_install custom resource. This is currently experimental, but will eventually be the only install method

## v2.0.4 (2015-12-03)

- Add a new attribute for setting transport protocols: default['activemq']['transport_protocols']

## v2.0.3 (2015-11-02)

- Install tar for minimal rhel installs that might not have it
- Test in Travis with kitchen-docker so each commit triggers a full integration test
- Update the development and testing gems in the Gemfile

## v2.0.2 (2015-09-24)

- Add new attributes for controlling the SSL settings

  - `default['activemq']['wrapper']['keystore_password']`
  - `default['activemq']['wrapper']['truststore_password']`
  - `default['activemq']['wrapper']['keystore_path']`
  - `default['activemq']['wrapper']['truststore_path']`

## v2.0.1 (2015-09-11)

- Update metadata for the move from opscode-cookbooks to chef-cookbooks
- Resolve rubocop warnings in the Rakefile and Rake tasks
- Remove incorrect development documentation in the readme
- Update the author to be the Cookbook Engineering Team
- Add additional development gems for rake and cloud testing

## v2.0.0 (2015-09-07)

- Default to ActiveMQ version 5.12.0
- Updated to the latest out of the box ActiveMQ config XML file so that newer installs could be successfully started. This is a 100% breaking change for older ActiveMQ installs.
- Added new attribute to decide if the service should be started or not: `node['activemq']['enabled']`. Defaults to true, but can be used with wrapper cookbooks that need to install additional configs before starting ActiveMQ
- Added new attribute to decide if Java should be installed or not: `node['activemq']['install_java']`. Defaults to true
- Fixed wrapper.conf to only template if `node['activemq']['use_default_config']` is set
- Updated Berksfile to 3.0 format
- Update Kitchen CI config with additional platforms and the attributes necessary for a clean converge
- Update Travis CI to test on Ruby 2/2.1/2.2 and to use the containe infrastructure and bundler caching for faster tests
- Removed yum as a dependency in the Berksfile since it's not actually used anywhere
- Added the new contributing and testing docs
- Add a maintainers file
- Updated all development dependencies in the Gemfile
- Clarified that Chef 11+ is required in the readme
- Added Travis and Supermarket badges in the readme
- Added scientific oracle, and amazon to the metdata file
- Add source_url and issues_url metadata to the metadata file
- Added minimal Chefspec to test recipe convergence
- Updated .gitignore and added a chefignore file
- Fix serverspec tests to run with the the latest serverspec release

## v1.3.5

- Adding global amq distribution service switch

## v1.3.4 (Development)

## v1.3.3 (2015-04-03)

- Metadata includes `issues_url` and `source_url`

## v1.3.2 (2014-04-23)

- [COOK-4557] activemq cookbook default mirror url is broken

## v1.3.0

### Bug

- **[COOK-3309](https://tickets.opscode.com/browse/COOK-3309)** - Fix service (re)start command
- **[COOK-2846](https://tickets.opscode.com/browse/COOK-2846)** - Add support for openSUSE
- **[COOK-2845](https://tickets.opscode.com/browse/COOK-2845)** - Support differing versions of `wrapper.conf`

## v1.2.0

### New Feature

- **[COOK-1777](https://tickets.opscode.com/browse/COOK-1777)** - Add stomp integration

## v1.1.0

- [COOK-2816] - update version to 5.8.0
- [COOK-2817] - resolve foodcritic warning

## v1.0.2

- [COOK-800] - activemq cookbook should install 5.5.1 by default
- [COOK-872] - activemq home directory isn't explicitly created
