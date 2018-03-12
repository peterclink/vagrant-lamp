# Vagrant LAMP (Linux Apache MySQL PHP)
Personal configuration for the setup of a LAMP server with Vagrant.<br />
You can choose a machine with php 5.6 or 7.1.

## Requirements
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* [Git](https://git-scm.com/)

## Technical Details
* Ubuntu 14.04 64-bit
* Apache 2.4
* PHP 7.1 or 5.6
* MySQL 5.5
* PHPMyAdmin
* XDebug
* Composer
* Git

## Installation
Clone the repository
```
$ git clone https://github.com/peterclink/vagrant-lamp.git
```

## Usage

### PHP 5.6
Run the commands
```
$ cd vagrant-lamp
$ vagrant up php56
```

### PHP 7.1
Run the commands
```
$ cd vagrant-lamp
$ vagrant up php71
```

### MySql
Run the commands
```
$ cd vagrant-lamp
$ vagrant up mysql
```

Now you can access the `DocumentRoot` here http://192.168.33.10

## MySQL
Externally the MySQL server is available at port 3306 as usual.
* Host: 192.168.33.11
* Username: root
* Password: root

## PHPMyAdmin
You can access the `PHPMyAdmin` here http://192.168.33.10/phpmyadmin

##
We are using the base Ubuntu 14.04 box from Vagrant. If you don't already have it downloaded
the Vagrantfile has been configured to do it for you. This only has to be done once
for each account on your host computer.

The web root is located in the project directory at `www/` and you can install your files there

And like any other vagrant file you have SSH access with
```
$ vagrant ssh
```