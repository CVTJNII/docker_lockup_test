# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "opscode-ubuntu-14.04"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

  config.vm.hostname = "docker-crash-test"

  config.vm.provider :virtualbox do |p|
    p.customize ["modifyvm", :id, "--memory", "2048"]
    p.customize ["modifyvm", :id, "--cpus", 4]
  end

  config.vm.provision "shell", path: 'setup_vm.sh'
end
