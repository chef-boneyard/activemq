instance = 'docs'

describe user("activemq_#{instance}") do
  it { should exist }
end

describe group("activemq_#{instance}") do
  it { should exist }
end

describe command("/opt/activemq_#{instance}/bin/activemq producer") do
  its('stdout') { should match(/Produced: 1000 messages/) }
end

describe command("opt/activemq_#{instance}/bin/activemq consumer") do
  its('stdout') { should match(/Consumed: 1000 messages/) }
end

describe service("activemq_#{instance}") do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
