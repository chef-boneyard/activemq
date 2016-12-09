property :instance_name, String, name_property: true
property :version, String, default: '5.14.0'
property :install_path, String, default: lazy { |r| "/opt/activemq_#{r.instance_name}_#{r.version.tr('.', '_')}/" }
property :tarball_base_path, String, default: 'http://archive.apache.org/dist/activemq/'
property :checksum_base_path, String, default: 'http://archive.apache.org/dist/activemq/'
property :exclude_docs, [true, false], default: true
property :exclude_examples, [true, false], default: true
property :exclude_webapp_demo, [true, false], default: true
property :tarball_uri, String
property :activemq_user, String, default: lazy { |r| "activemq_#{r.instance_name}" }
property :activemq_group, String, default: lazy { |r| "activemq_#{r.instance_name}" }

action_class do
  # build the extraction command based on the passed properties
  def extraction_command
    cmd = "tar -xzf #{Chef::Config['file_cache_path']}/apache-activemq-#{new_resource.version}-bin.tar.gz -C #{new_resource.install_path} --strip-components=1"
    cmd << " --exclude='*examples*'" if new_resource.exclude_examples
    cmd << " --exclude='*docs*'" if new_resource.exclude_docs
    cmd << " --exclude='*webapps-demo*'" if new_resource.exclude_webapp_demo
    cmd
  end

  # ensure the version is X.Y.Z format
  def validate_version
    return if new_resource.version =~ /\d+.\d+.\d+/
    Chef::Log.fatal("The version must be in X.Y.Z format. Passed value: #{new_resource.version}")
    raise
  end

  # fetch the shasum checksum from the mirrors
  # we have to do this since apache doesn't have a sha256 like chef expects
  def fetch_checksum
    uri = if new_resource.tarball_uri.nil?
            URI.join(new_resource.checksum_base_path, "#{new_resource.version}/apache-activemq-#{new_resource.version}-bin.tar.gz.sha1")
          else
            URI("#{new_resource.tarball_uri}.sha1")
          end
    request = Net::HTTP.new(uri.host, uri.port)
    response = request.get(uri)
    if uri.to_s.start_with?('https')
      request.use_ssl = true
      request.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    if response.code != '200'
      Chef::Log.fatal("Fetching the activemq tarball checksum at #{uri} resulted in an error #{response.code}")
      raise
    end
    response.body.split(' ')[0]
  rescue => e
    Chef::Log.fatal("Could not fetch the checksum due to an error: #{e}")
    raise
  end

  # validate the mirror checksum against the on disk checksum
  # return true if they match. Append .bad to the cached copy to prevent using it next time
  def validate_checksum(file_to_check)
    desired = fetch_checksum
    actual = Digest::SHA1.hexdigest(::File.read(file_to_check))

    if desired == actual
      true
    else
      Chef::Log.fatal("The checksum of the activemq tarball on disk (#{actual}) does not match the checksum provided from the mirror (#{desired}). Renaming to #{::File.basename(file_to_check)}.bad")
      ::File.rename(file_to_check, "#{file_to_check}.bad")
      raise
    end
  end

  # build the complete tarball URI and handle basepath with/without trailing /
  def tarball_uri
    uri = ''
    if new_resource.tarball_uri.nil?
      uri << new_resource.tarball_base_path
      uri << '/' unless uri[-1] == '/'
      uri << "#{new_resource.version}/apache-activemq-#{new_resource.version}-bin.tar.gz"
    else
      uri << new_resource.tarball_uri
    end
    uri
  end
end

action :install do
  validate_version

  # some RHEL systems lack tar in their minimal install
  package 'tar'

  group new_resource.activemq_group do
    action :create
    append true
  end

  user new_resource.activemq_user do
    gid new_resource.activemq_group
    shell '/bin/false'
    system true
    action :create
  end

  directory 'activemq install dir' do
    mode '0750'
    path new_resource.install_path
    recursive true
    owner new_resource.activemq_user
    group new_resource.activemq_group
  end

  remote_file "activemq #{new_resource.version} tarball" do
    source tarball_uri
    path "#{Chef::Config['file_cache_path']}/apache-activemq-#{new_resource.version}-bin.tar.gz"
    verify { |file| validate_checksum(file) }
  end

  execute 'extract activemq tarball' do
    command extraction_command
    action :run
    creates ::File.join(new_resource.install_path, 'LICENSE')
  end

  # make sure the instance's user owns the instance install dir
  execute "chown install dir as activemq_#{new_resource.instance_name}" do
    command "chown -R #{new_resource.activemq_user}:#{new_resource.activemq_group} #{new_resource.install_path}"
    action :run
    not_if { Etc.getpwuid(::File.stat("#{new_resource.install_path}/LICENSE").uid).name == new_resource.activemq_user }
  end

  # create a link that points to the latest version of the instance
  link "/opt/activemq_#{new_resource.instance_name}" do
    to new_resource.install_path
  end
end
