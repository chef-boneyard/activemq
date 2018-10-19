activemq_version = attribute('activemq_version',
                             default: '5.14.5',
                             description: 'Which version of ActiveMQ is to be installed'
                            )
activemq_install_dir = attribute('activemq_install_directory',
                                 default: "/opt/apache-activemq-#{activemq_version}",
                                 description: 'Get the path where ActiveMQ should be installed'
                                )
activemq_service_enabled = attribute('activemq_service_enabled',
                                     default: true,
                                     description: 'Enable and start ActiveMQ servers when true'
                                    )

arch = os[:arch] == 'x86_64' ? 'x86-64' : 'x86-32'

control 'check-tar-installation' do
  impact 1.0
  title 'Verify that the tar package is installed'
  desc 'Verify tar is installed so ActiveMQ can be installed'

  describe package('tar') do
    it { should be_installed }
  end
end

control 'check-activemq-binary-perms' do
  impact 1.0
  title 'Verify that the ActiveMQ binary permissions are correct'
  desc 'Verify ActiveMQ binary has the correct permissions'

  describe file("#{activemq_install_dir}/bin/activemq") do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp 0o755 }
    its('group') { should eq 'root' }
    its('owner') { should eq 'root' }
  end
end

control 'check-init.d-link' do
  impact 1.0
  title 'Verify the run level start/stop link got installed'
  desc 'Verify that start-stop link got installed in /etc/init.d'

  describe file('/etc/init.d/activemq') do
    it { should exist }
    it { should be_symlink }
    its('link_path') { should eq "#{activemq_install_dir}/bin/linux-#{arch}/activemq" }
  end
end

control 'activemq-service-status' do
  impact 1.0
  title 'Verify the ActiveMQ service is set when flag is true'
  desc 'Verify the ActiveMQ service is running and enabled when true'

  if activemq_service_enabled
    describe service('activemq') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
  else
    describe service('activemq') do
      it { should_not be_installed }
      it { should_not be_enabled }
      it { should_not be_running }
    end
  end
end

control 'check-wrapper-conf-link' do
  impact 1.0
  title 'Verify link from bin/linux to bin/linux-arch'
  desc 'Verify link to bin/lunx to bin/linux-arch exists for wrapper.conf'

  describe file("#{activemq_install_dir}/bin/linux") do
    it { should exist }
    it { should be_symlink }
    its('link_path') { should eq "#{activemq_install_dir}/bin/linux-#{arch}" }
  end
end

control 'check-pid-file-link' do
  impact 1.0
  title 'Verify link from pid file to /var/run/activemq.pid'
  desc 'Verify link from pid file to /var/run/activemq.pid exists'

  describe file('/var/run/activemq.pid') do
    it { should exist }
    it { should be_symlink }
    its('link_path') { should eq "#{activemq_install_dir}/bin/linux-#{arch}/ActiveMQ.pid" }
  end
end

control 'check-for-running-activemq' do
  impact 1.0
  title 'Verify that the ActiveMQ process is running'
  desc 'Verify that there is a running process for ActiveMQ'

  describe command('ps ax | grep activem[q]') do
    its('exit_status') { should eq 0 }
  end
end

control 'check-for-producer-messages' do
  impact 1.0
  title 'Verify that the ActiveMQ producer messages is 1000'
  desc 'Verify that ActiveMQ produces messages'

  describe command("/opt/apache-activemq-#{activemq_version}/bin/activemq producer") do
    its('stdout') { should match(/Produced: 1000 messages/) }
  end
end

control 'check-for-consumer-messages' do
  impact 1.0
  title 'Verify that the ActiveMQ consumer messages is 1000'
  desc 'Verify that ActiveMQ produces messages'

  describe command("/opt/apache-activemq-#{activemq_version}/bin/activemq consumer") do
    its('stdout') { should match(/Consumed: 1000 messages/) }
  end
end
