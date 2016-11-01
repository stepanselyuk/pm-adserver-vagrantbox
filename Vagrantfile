# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("vagrant-vbguest")
  system('vagrant plugin install vagrant-vbguest')
  raise("Plugin installed. Run command again.");
end

Vagrant.configure(2) do |config|

  config.vm.box = "boxcutter/centos72"
  
  config.vm.provision :shell, path: "bootstrap-system.sh"
  config.vm.provision :shell, path: "bootstrap-git.sh"
  config.vm.provision :shell, path: "bootstrap-ruby.sh"
  config.vm.provision :shell, path: "bootstrap-ruby-pkgs.sh"
  config.vm.provision :shell, path: "bootstrap-nodejs.sh"
  config.vm.provision :shell, path: "bootstrap-composer.sh"
  config.vm.provision :shell, path: "bootstrap-apache-init.sh"
  config.vm.provision :shell, path: "bootstrap-mysql-init.sh"
  config.vm.provision :shell, path: "bootstrap-redis.sh"
  config.vm.provision :shell, path: "bootstrap-nsq.sh"
  config.vm.provision :shell, path: "bootstrap-supervisor.sh"

  config.vm.provider "virtualbox" do |vb|
     # won't run VirtualBox GUI
     vb.gui = false
     # allowed memory in megabytes for this VM
     vb.memory = 2048
     # allowed CPU cores for use
     # better to set equals real count of your CPU cores
     vb.cpus = 4
  end

  # You need to replace "~/adserver" to your custom path
  # @see https://docs.vagrantup.com/v2/synced-folders/index.html

  # By default you can use project from your local folder,
  # Second choice you can run 'sh /vagrant/project-init.sh' from 'vagrant' user env,
  # and this way you need an empty shared directory, because all content from it will be deleted.

  # config.vm.synced_folder "~/adserver", "/var/www/vhosts"
  # especially for MacOS (rapid!):
  config.vm.synced_folder "/Volumes/WebDevHD/adserver", "/var/www/vhosts", type: "nfs"

  # @see https://docs.vagrantup.com/v2/networking/index.html
  # Examples:
  # 1st needed for sharing using NFS
  config.vm.network :private_network, type: "dhcp"
  # config.vm.network :private_network, ip: "10.0.2.21"
  # config.vm.network :public_network, ip: "192.168.11.150", bridge: 'en0: Wi-Fi (AirPort)'
  # config.vm.network :public_network, ip: "192.168.11.234", bridge: 'en0: Wi-Fi (AirPort)'

  # @see https://docs.vagrantup.com/v2/networking/forwarded_ports.html

  # HTTP backend
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

  # NSQ Admin
  config.vm.network "forwarded_port", guest: 4171, host: 4171, auto_correct: true

  # Overriding default ssh 2222 port - if needed - it's convenient with multiple vagrant boxes
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
  config.vm.network :forwarded_port, guest: 22, host: 2280, auto_correct: true

end