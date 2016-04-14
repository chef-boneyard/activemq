property :instance_name, String, name_property: true
property :version, String, required: true, default: '5.13.2'
property :install_path, String
property :tarball_base_path, String, default: 'http://archive.apache.org/dist/activemq/'
property :checksum_base_path, String, default: 'http://archive.apache.org/dist/activemq/'

action_class do
  # the install path of this instance of activemq
  def full_install_path
    if new_resource.install_path
      new_resource.install_path
    else
      @path ||= "/opt/activemq_#{new_resource.instance_name}_#{new_resource.version.tr('.', '_')}/"
    end
  end

  # build the extraction command
  def extraction_command
    "tar -xzf #{Chef::Config['file_cache_path']}/apache-activemq-#{new_resource.version}-bin.tar.gz -C #{full_install_path} --strip-components=1"
  end

  # ensure the version is X.Y.Z format
  def validate_version
    unless new_resource.version =~ /\d+.\d+.\d+/
      Chef::Log.fatal("The version must be in X.Y.Z format. Passed value: #{new_resource.version}")
      raise
    end
  end

  # fetch the md5 checksum from the mirrors
  # we have to do this since the md5 chef expects isn't hosted
  def fetch_checksum
    uri = URI.join(new_resource.checksum_base_path, "#{new_resource.version}/apache-activemq-#{new_resource.version}-bin.tar.gz.md5")
    request = Net::HTTP.new(uri.host, uri.port)
    response = request.get(uri)
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
    actual = Digest::MD5.hexdigest(::File.read(file_to_check))

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
    uri << new_resource.tarball_base_path
    uri << '/' unless uri[-1] == '/'
    uri << "#{new_resource.version}/apache-activemq-#{new_resource.version}-bin.tar.gz"
    uri
  end
end

action :install do
  validate_version

  # some RHEL systems lack tar in their minimal install
  package 'tar'

  remote_file "apache #{new_resource.version} tarball" do
    source tarball_uri
    path "#{Chef::Config['file_cache_path']}/apache-activemq-#{new_resource.version}-bin.tar.gz"
    verify { |file| validate_checksum(file) }
  end

  directory 'activemq install dir' do
    mode '0750'
    path full_install_path
    recursive true
  end

  execute 'extract activemq tarball' do
    command extraction_command
    action :run
    creates ::File.join(full_install_path, 'LICENSE')
  end

  group "activemq_#{new_resource.instance_name}" do
    action :create
  end

  user "activemq_#{new_resource.instance_name}" do
    gid "activemq_#{new_resource.instance_name}"
    shell '/bin/nologin'
    action :create
  end

  # make sure the instance's user owns the instance install dir
  execute "chown install dir as activemq_#{new_resource.instance_name}" do
    command "chown -R activemq_#{instance_name}:root #{full_install_path}"
    action :run
    not_if { Etc.getpwuid(::File.stat("#{full_install_path}/LICENSE").uid).name == "activemq_#{new_resource.instance_name}" }
  end

  # create a link that points to the latest version of the instance
  link "/opt/activemq_#{new_resource.instance_name}" do
    to full_install_path
  end
end
