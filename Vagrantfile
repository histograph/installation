# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define 'hg', autostart: true do |host|
    host.vm.box = 'hashicorp/precise64' # Ubuntu 12.04 64bit
    host.vm.hostname = 'hg'
    host.vm.network 'private_network', type: 'dhcp'
    host.vm.provider 'virtualbox' do |v|
        v.customize ['modifyvm', :id, '--cpus', 2]
        v.customize ['modifyvm', :id, '--memory', '2048']
    end
    host.vm.provision 'shell', path: 'puppet/setup.sh'
    host.vm.synced_folder 'puppet', '/etc/puppet'

  end

  config.vm.network "forwarded_port", guest: 3000, host: 3000 # Histograph Viewer
  config.vm.network "forwarded_port", guest: 3001, host: 3001 # nodejs histograph:api
  config.vm.network "forwarded_port", guest: 7474, host: 7474 # java neo4j
  config.vm.network "forwarded_port", guest: 9200, host: 9200 # java elasticsearch


end
