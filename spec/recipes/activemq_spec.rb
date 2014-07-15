require_relative '../spec_helper.rb'
require 'chef'
describe 'activemq::default' do
  
  let(:chef_run) { 
      ChefSpec::Runner.new do | node |
        node.set['activemq']['brokerName'] = 'VASVASVAS'
        node.set['activemq']['use_default_config'] = true
        node.set['activemq']['admin_console']['customize'] = 'true'
        node.set['activemq']['admin_console']['port'] = '9161'
        node.set['activemq']['admin_console']['credentials']['customize'] = 'true'
        node.set['activemq']['admin_console']['credentials']['user_name'] = 'vas'
        node.set['activemq']['admin_console']['credentials']['password'] = 'vas'
        node.set['activemq']['admin_console']['new_admin_console_name'] = 'VASVASVAS'
    end.converge(described_recipe) 
  }

  before do
    stub_command("test -f /var/run/activemq.pid").and_return(true)
  end
  
  it "Has activemq service enabled?" do
    expect(chef_run).to enable_service('activemq')
  end

  it "Start activemq service" do
    expect(chef_run).to start_service('activemq')
  end

  it "Validate customize 'brokerName' name" do 
    expect(chef_run).to render_file('/opt/apache-activemq-5.9.1/conf/activemq.xml').with_content(/brokerName="VASVASVAS"/)
  end 

  describe "Validate 'admin' console customization" do 
    it "Check admin console port?" do 
      expect(chef_run).to render_file('/opt/apache-activemq-5.9.1/conf/jetty.xml').with_content(/property name="port" value="9161"/)
    end
    it "Check admin console user name and password?" do 
      expect(chef_run).to render_file('/opt/apache-activemq-5.9.1/conf/jetty-realm.properties').with_content(/vas: vas/)
    end 
    
    it "Check admin console application new name?" do 
      
      expect(chef_run).to render_file('/opt/apache-activemq-5.9.1/conf/jetty.xml').with_content(/property name="contextPath" value="\/VASVASVAS"/)
    end 
  end

end