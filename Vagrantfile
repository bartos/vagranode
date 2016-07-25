# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
echo I am provisioning...
date > /etc/vagrant_provisioned_at
echo this is a newly provisioned element, just for test >> /etc/vagrant_provisioned_at
SCRIPT

boxes = [
  {
    :name => 'master',
    :ip   => '10.0.9.111',
    :sync => [
      {
        :host => "salt/",
        :guest => "/srv/salt"
      },
    ],
    :provision => {
      :type => "salt",
    },

    
  },
  {
    :name => 'slave1',
    :ip   => '10.0.9.112',
    :sync => {}
  },
  {
    :name => 'slave2',
    :ip   => '10.0.9.113',
    :sync => {}
  },
]

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  boxes.each do |box|
    config.vm.define box[:name] do |m|
      m.vm.hostname=box[:name]
      m.vm.provider "virtualbox" do |v|
        v.memory=512
        v.cpus=1  #0.7 seems impossible Oo_
      end

      m.vm.network "private_network", ip: box[:ip]
#      m.vm.network "forwarded_port", guest: 8080, host:8080
#      sync directories
      
      box[:sync].each do |sync|
        m.vm.synced_folder sync[:host], sync[:guest]
      end
  
      if box.key?(:provision)
        m.vm.provision "shell", inline: $script
      end

    end




  end

end
