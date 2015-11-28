# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define 'hg', autostart: true do |host|
    host.vm.box = 'puppetlabs/ubuntu-12.04-64-puppet'
    host.vm.hostname = 'hg'
    host.vm.network 'private_network', type: 'dhcp'
    host.vm.provider 'virtualbox' do |v|
        v.customize ['modifyvm', :id, '--cpus', 2]
        v.customize ['modifyvm', :id, '--memory', '2048']
    end
    host.vm.provision 'shell', path: 'puppet/setup.sh'
    host.vm.synced_folder 'puppet', '/etc/puppet'

  end

  config.vm.define 'ra', autostart: false do |host|
    host.vm.box = 'puppetlabs/ubuntu-12.04-64-puppet'
    host.vm.hostname = 'ra'
    host.vm.network 'private_network', type: 'dhcp'
    host.vm.provider 'virtualbox' do |v|
        v.customize ['modifyvm', :id, '--cpus', 2]
        v.customize ['modifyvm', :id, '--memory', '2048']
    end
    host.vm.provision 'shell', path: 'puppet/setup.sh'
    host.vm.synced_folder 'puppet', '/etc/puppet'
  end

  # neo4j
  config.vm.network "forwarded_port", guest: 7474, host: 7474


end
