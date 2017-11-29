# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "www", "/var/www"
  
  config.vm.define "lamp56" do |lamp56|
    lamp56.vm.hostname = "lamp56"
    lamp56.vm.provision "shell", path: "config/setup-php-5.6.sh"

    lamp56.vm.provider "virtualbox" do |v|
      v.name = "lamp56"
      v.customize ["modifyvm", :id, "--name", "lamp56"]
    end
  end

  config.vm.define "lamp71" do |lamp71|
    lamp71.vm.hostname = "lamp71"
    lamp71.vm.provision "shell", path: "config/setup-php-7.1.sh"

    lamp71.vm.provider "virtualbox" do |v|
      v.name = "lamp71"
      v.customize ["modifyvm", :id, "--name", "lamp71"]
    end
  end
end
