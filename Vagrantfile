# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "centos" do |centos|
    centos.vm.box = "centos64"
    centos.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.4_chef-provisionerless.boxx"
    centos.omnibus.chef_version = :latest
    centos.vm.network :private_network, ip: "192.168.254.10"
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu-1204"
    ubuntu.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"
    ubuntu.omnibus.chef_version = :latest
    ubuntu.vm.network :private_network, ip: "192.168.254.12"
  end
  
  
  config.vm.boot_timeout = 120
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
    }
    chef.run_list = [
      "recipe[rackspace_activemq]"
    ]
  end
end

