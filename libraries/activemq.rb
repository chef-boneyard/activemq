#
# Cookbook Name:: activemq
# Library:: activemq
#
#
# Copyright 2016, Chef Software, Inc.
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

# the install path of this instance of activemq
# make sure it doesn't end in / as well as that causes issues in init scripts

def derived_install_path
  new_resource.install_path ? new_resource.install_path.chomp('/') : "/opt/activemq_#{new_resource.instance_name}"
end
