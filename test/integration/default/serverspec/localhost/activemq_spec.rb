require 'spec_helper'

describe 'ActiveMQ server' do
  it 'should have a vagrant user' do
    expect(user('vagrant')).to exist
  end

  it 'should be running the activemq server' do
    expect(service('activemq')).to be_running
    expect(service('activemq')).to be_enabled
  end
end
