require 'spec_helper'

describe 'default recipe on ubuntu 16.04' do
  let(:runner) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') }
  let(:chef_run) { runner.converge('activemq::default') }

  before do
    stub_command('test -f /var/run/activemq.pid')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
