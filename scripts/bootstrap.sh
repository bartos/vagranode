#!/usr/bin/env bash

wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -

add-apt-repository 'deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main'


apt-get update
apt-get install -y apache2 mc

apt-get install -y git

# saltstack
ln -fs /vagrant/srv/salt /srv/salt #think about git
apt-get install -y salt-master salt-minion salt-ssh salt-api
echo master: localhost >> /etc/salt/minion
service salt-minion restart
echo "SLEEPING SOME TIME FOR SALT_MINION RESTART"
sleep 15

## Accept eldritch minion
salt-key -a eldritch --yes


#JAVA NODEJS USERS SONAR JENKINS 
salt \* state.highstate


## APACHE DIRECTORY
if ! [ -L /var/www ]; then
	ln -fs /vargant /var/www/host
fi
