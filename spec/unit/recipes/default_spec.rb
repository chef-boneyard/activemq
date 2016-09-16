require 'spec_helper'

describe 'default recipe' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.converge('activemq::default')
  end

  before do
    stub_command('test -f /var/run/activemq.pid')
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
end
