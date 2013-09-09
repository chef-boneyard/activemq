#
# Cookbook Name:: activemq
# Library:: chef_activemq
#
# Author:: Bernardo Gomez Palacio (<bernardo.gomezpalacio@gmail.com>)
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
#
class Chef
  module ActiveMQ

    class << self

      # Returns the name of the jar file that contains the ActiveMQ main classes. Since ActiveMQ 5.8.0 the name
      # of such jar file is "activemq.jar", prior to that it was "run.jar".
      #
      # @param node [Chef::Node] the Chef node
      #
      # @return [String] the name of the ActiveMQ jar file that should be included in the JVM Classpath.
      def get_amq_jar_name(node)

          version = node['activemq']['version']

          vMj,vMn,vRev = version.split(".").map{ |v|  Integer(v) rescue nil }
          runner = case
                   when vMj == 5 && vMn >= 8
                       "activemq.jar"
                   when vMj >= 6
                       "activemq.jar"
                   else
                       "run.jar"
                   end
          runner
      end
    end
  end
end
