# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder "/Users/plink/Projects", "/var/www", owner: "www-data", group: "www-data"
  
  config.vm.define "php56" do |php56|
    php56.vm.hostname = "php56"
    php56.vm.provision "shell", path: "config/setup-php-5.6.sh"
    php56.vm.network "private_network", ip: "192.168.33.10"

    php56.vm.provider "virtualbox" do |v|
      v.name = "php56"
      v.gui = false
      v.customize ["modifyvm", :id, "--name", "php56"]
    end
  end

  config.vm.define "php71" do |php71|
    php71.vm.hostname = "php71"
    php71.vm.provision "shell", path: "config/setup-php-7.1.sh"
    php71.vm.network "private_network", ip: "192.168.33.10"

    php71.vm.provider "virtualbox" do |v|
      v.name = "php71"
      v.gui = false
      v.customize ["modifyvm", :id, "--name", "php71"]
    end
  end

  config.vm.define "mysql" do |mysql|
    mysql.vm.hostname = "mysql"
    mysql.vm.provision "shell", path: "config/setup-mysql.sh"
    mysql.vm.network "forwarded_port", guest: 3306, host: 3306
    mysql.vm.network "private_network", ip: "192.168.33.11"

    mysql.vm.provider "virtualbox" do |v|
      v.name = "mysql"
      v.gui = false
      v.customize ["modifyvm", :id, "--name", "mysql"]
    end
  end
end
