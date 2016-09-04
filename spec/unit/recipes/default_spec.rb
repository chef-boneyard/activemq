require 'spec_helper'

describe 'default recipe' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node|
      node.automatic[:lsb][:codename] = 'trusty'
    end.converge('activemq::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
