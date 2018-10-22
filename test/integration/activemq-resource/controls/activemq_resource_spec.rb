activemq_version = attribute('activemq_version',
                             default: '5.14.5',
                             description: 'Which version of ActiveMQ is to be installed'
                            )
activemq_instance_name = attribute('activemq_instance_name',
                                   default: 'main_queue',
                                   description: 'Instance being created, which is also the user/group names'
                                  )
activemq_group_name = attribute('activemq_group_name',
                                default: "activemq_#{activemq_instance_name}",
                                description: 'Get the group name to use for permissions of the instance'
                               )
activemq_user_name = attribute('activemq_user_name',
                                default: "activemq_#{activemq_instance_name}",
                                description: 'Get the name name to use for permissions of the instance'
                              )
activemq_install_dir = attribute('activemq_install_directory',
                                 default: "/opt/activemq_#{activemq_instance_name}_#{activemq_version.tr('.', '_')}",
                                 description: 'Get the path where ActiveAQ should be installed'
                                )

control 'check-tar-installation' do
  impact 1.0
  title 'Verify that the tar package is installed'
  desc 'Verify tar is installed so ActiveAQ can be installed'

  describe package('tar') do
    it { should be_installed }
  end
end

control 'check-group-name' do
  impact 1.0
  title 'Verify that the group is created'
  desc 'Verify that /etc/group contains an entry for the instance name'

  describe group(activemq_group_name) do
    it { should exist }
  end
end

control 'check-user-name' do
  impact 1.0
  title 'Verify that the user is created'
  desc 'Verify that /etc/passwd contains an entry for the instance name'

  describe group(activemq_user_name) do
    it { should exist }
  end
end

control 'check-install-directory' do
  impact 1.0
  title 'Verify the install directory has been created'
  desc 'Verify the existence of the ActiveAQ installation directory'

  describe directory(activemq_install_dir) do
    it { should exist }
    it { should be_directory }
    its('path') { should eq activemq_install_dir }
    its('mode') { should cmp 0o750 }
    its('group') { should eq activemq_group_name }
    its('owner') { should eq activemq_user_name }
  end
end

control 'check-install-link' do
  impact 1.0
  title 'Verify the link to the install directory has been created'
  desc 'Verify the existence of the link to the installation directory'

  describe file("/opt/activemq_#{activemq_instance_name}") do
    it { should exist }
    it { should be_symlink }
    its('link_path') { should eq activemq_install_dir }
  end
end
